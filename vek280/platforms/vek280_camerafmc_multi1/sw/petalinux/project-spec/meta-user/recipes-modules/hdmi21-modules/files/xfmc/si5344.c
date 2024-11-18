// SPDX-License-Identifier: GPL-2.0
/*
 * Driver for Silicon Labs Si5344 clock generator
 *
 * Copyright (C) 2022 Xilinx, Inc.
 *
 * Author: Rajesh Gugulothu <gugulothu.rajesh@xilinx.com>
 *
 * This driver configures the SI5344 chip to generate constant 400MHz FRL clock
 * Note: This is not a common clock framwork driver.
 */
#include <linux/clk.h>
#include <linux/clk-provider.h>
#include <linux/delay.h>
#include <linux/gcd.h>
#include <linux/math64.h>
#include <linux/i2c.h>
#include <linux/module.h>
#include <linux/regmap.h>
#include <linux/slab.h>
#include <asm/unaligned.h>

int si5344_entry(void);
void si5344_exit(void);

struct clk_si5344 {
	struct clk_hw hw;
	struct regmap *regmap;
	struct i2c_client *i2c_client;
};

#define SI5344_PAGE		0x0001
#define SI5344_REGISTER_MAX	0xBFF

/* Static configuration (to be moved to firmware) */
struct si5344_reg_default {
	u16 address;
	u8 value;
};

static const struct si5344_reg_default si5344_preamble[] = {
	{ 0x0B24, 0xC0 },
	{ 0x0B25, 0x00 },
	{ 0x0540, 0x01 },
};

static const struct si5344_reg_default si5344_postamble[] = {
	{ 0x0514, 0x01 },
	{ 0x001C, 0x01 },
	{ 0x0540, 0x00 },
	{ 0x0B24, 0xC3 },
	{ 0x0B25, 0x02 },
};

static const struct si5344_reg_default si5344_reg_defaults[] = {
	{ 0x0006, 0x00 },
	{ 0x0007, 0x00 },
	{ 0x0008, 0x00 },
	{ 0x000B, 0x68 },
	{ 0x0016, 0x02 },
	{ 0x0017, 0xDC },
	{ 0x0018, 0xFF },
	{ 0x0019, 0xFF },
	{ 0x001A, 0xFF },
	{ 0x002B, 0x02 },
	{ 0x002C, 0x00 },
	{ 0x002D, 0x00 },
	{ 0x002E, 0x00 },
	{ 0x002F, 0x00 },
	{ 0x0030, 0x00 },
	{ 0x0031, 0x00 },
	{ 0x0032, 0x00 },
	{ 0x0033, 0x00 },
	{ 0x0034, 0x00 },
	{ 0x0035, 0x00 },
	{ 0x0036, 0x00 },
	{ 0x0037, 0x00 },
	{ 0x0038, 0x00 },
	{ 0x0039, 0x00 },
	{ 0x003A, 0x00 },
	{ 0x003B, 0x00 },
	{ 0x003C, 0x00 },
	{ 0x003D, 0x00 },
	{ 0x003F, 0x00 },
	{ 0x0040, 0x04 },
	{ 0x0041, 0x00 },
	{ 0x0042, 0x00 },
	{ 0x0043, 0x00 },
	{ 0x0044, 0x00 },
	{ 0x0045, 0x0C },
	{ 0x0046, 0x00 },
	{ 0x0047, 0x00 },
	{ 0x0048, 0x00 },
	{ 0x0049, 0x00 },
	{ 0x004A, 0x00 },
	{ 0x004B, 0x00 },
	{ 0x004C, 0x00 },
	{ 0x004D, 0x00 },
	{ 0x004E, 0x00 },
	{ 0x004F, 0x00 },
	{ 0x0050, 0x0F },
	{ 0x0051, 0x00 },
	{ 0x0052, 0x00 },
	{ 0x0053, 0x00 },
	{ 0x0054, 0x00 },
	{ 0x0055, 0x00 },
	{ 0x0056, 0x00 },
	{ 0x0057, 0x00 },
	{ 0x0058, 0x00 },
	{ 0x0059, 0x00 },
	{ 0x005A, 0x00 },
	{ 0x005B, 0x00 },
	{ 0x005C, 0x00 },
	{ 0x005D, 0x00 },
	{ 0x005E, 0x00 },
	{ 0x005F, 0x00 },
	{ 0x0060, 0x00 },
	{ 0x0061, 0x00 },
	{ 0x0062, 0x00 },
	{ 0x0063, 0x00 },
	{ 0x0064, 0x00 },
	{ 0x0065, 0x00 },
	{ 0x0066, 0x00 },
	{ 0x0067, 0x00 },
	{ 0x0068, 0x00 },
	{ 0x0069, 0x00 },
	{ 0x0092, 0x00 },
	{ 0x0093, 0x00 },
	{ 0x0095, 0x00 },
	{ 0x0096, 0x00 },
	{ 0x0098, 0x00 },
	{ 0x009A, 0x00 },
	{ 0x009B, 0x00 },
	{ 0x009D, 0x00 },
	{ 0x009E, 0x00 },
	{ 0x00A0, 0x00 },
	{ 0x00A2, 0x00 },
	{ 0x00A9, 0x00 },
	{ 0x00AA, 0x00 },
	{ 0x00AB, 0x00 },
	{ 0x00AC, 0x00 },
	{ 0x00E5, 0x01 },
	{ 0x00EA, 0x00 },
	{ 0x00EB, 0x00 },
	{ 0x00EC, 0x00 },
	{ 0x00ED, 0x00 },
	{ 0x0102, 0x01 },
	{ 0x0112, 0x06 },
	{ 0x0113, 0x09 },
	{ 0x0114, 0x3B },
	{ 0x0115, 0x28 },
	{ 0x0117, 0x06 },
	{ 0x0118, 0x09 },
	{ 0x0119, 0x3B },
	{ 0x011A, 0x28 },
	{ 0x0126, 0x06 },
	{ 0x0127, 0x09 },
	{ 0x0128, 0x3B },
	{ 0x0129, 0x28 },
	{ 0x012B, 0x06 },
	{ 0x012C, 0x09 },
	{ 0x012D, 0x3B },
	{ 0x012E, 0x28 },
	{ 0x013F, 0x00 },
	{ 0x0140, 0x00 },
	{ 0x0141, 0x40 },
	{ 0x0142, 0xFF },
	{ 0x0206, 0x00 },
	{ 0x0208, 0x00 },
	{ 0x0209, 0x00 },
	{ 0x020A, 0x00 },
	{ 0x020B, 0x00 },
	{ 0x020C, 0x00 },
	{ 0x020D, 0x00 },
	{ 0x020E, 0x00 },
	{ 0x020F, 0x00 },
	{ 0x0210, 0x00 },
	{ 0x0211, 0x00 },
	{ 0x0212, 0x00 },
	{ 0x0213, 0x00 },
	{ 0x0214, 0x00 },
	{ 0x0215, 0x00 },
	{ 0x0216, 0x00 },
	{ 0x0217, 0x00 },
	{ 0x0218, 0x00 },
	{ 0x0219, 0x00 },
	{ 0x021A, 0x00 },
	{ 0x021B, 0x00 },
	{ 0x021C, 0x00 },
	{ 0x021D, 0x00 },
	{ 0x021E, 0x00 },
	{ 0x021F, 0x00 },
	{ 0x0220, 0x00 },
	{ 0x0221, 0x00 },
	{ 0x0222, 0x00 },
	{ 0x0223, 0x00 },
	{ 0x0224, 0x00 },
	{ 0x0225, 0x00 },
	{ 0x0226, 0x00 },
	{ 0x0227, 0x00 },
	{ 0x0228, 0x00 },
	{ 0x0229, 0x00 },
	{ 0x022A, 0x00 },
	{ 0x022B, 0x00 },
	{ 0x022C, 0x00 },
	{ 0x022D, 0x00 },
	{ 0x022E, 0x00 },
	{ 0x022F, 0x00 },
	{ 0x0231, 0x0B },
	{ 0x0232, 0x0B },
	{ 0x0233, 0x0B },
	{ 0x0234, 0x0B },
	{ 0x0235, 0x00 },
	{ 0x0236, 0x00 },
	{ 0x0237, 0x00 },
	{ 0x0238, 0x80 },
	{ 0x0239, 0xD4 },
	{ 0x023A, 0x00 },
	{ 0x023B, 0x00 },
	{ 0x023C, 0x00 },
	{ 0x023D, 0x00 },
	{ 0x023E, 0xC0 },
	{ 0x0250, 0x00 },
	{ 0x0251, 0x00 },
	{ 0x0252, 0x00 },
	{ 0x0253, 0x00 },
	{ 0x0254, 0x00 },
	{ 0x0255, 0x00 },
	{ 0x025C, 0x00 },
	{ 0x025D, 0x00 },
	{ 0x025E, 0x00 },
	{ 0x025F, 0x00 },
	{ 0x0260, 0x00 },
	{ 0x0261, 0x00 },
	{ 0x026B, 0x00 },
	{ 0x026C, 0x00 },
	{ 0x026D, 0x00 },
	{ 0x026E, 0x00 },
	{ 0x026F, 0x00 },
	{ 0x0270, 0x00 },
	{ 0x0271, 0x00 },
	{ 0x0272, 0x00 },
	{ 0x028A, 0x00 },
	{ 0x028B, 0x00 },
	{ 0x028C, 0x00 },
	{ 0x028D, 0x00 },
	{ 0x028E, 0x00 },
	{ 0x028F, 0x00 },
	{ 0x0290, 0x00 },
	{ 0x0291, 0x00 },
	{ 0x0294, 0x80 },
	{ 0x0296, 0x00 },
	{ 0x0297, 0x00 },
	{ 0x0299, 0x00 },
	{ 0x029D, 0x00 },
	{ 0x029E, 0x00 },
	{ 0x029F, 0x00 },
	{ 0x02A9, 0x00 },
	{ 0x02AA, 0x00 },
	{ 0x02AB, 0x00 },
	{ 0x02B7, 0xFF },
	{ 0x0302, 0x00 },
	{ 0x0303, 0x00 },
	{ 0x0304, 0x00 },
	{ 0x0305, 0x80 },
	{ 0x0306, 0x08 },
	{ 0x0307, 0x00 },
	{ 0x0308, 0x00 },
	{ 0x0309, 0x00 },
	{ 0x030A, 0x00 },
	{ 0x030B, 0x80 },
	{ 0x030C, 0x00 },
	{ 0x030D, 0x00 },
	{ 0x030E, 0x00 },
	{ 0x030F, 0x00 },
	{ 0x0310, 0x00 },
	{ 0x0311, 0x00 },
	{ 0x0312, 0x00 },
	{ 0x0313, 0x00 },
	{ 0x0314, 0x00 },
	{ 0x0315, 0x00 },
	{ 0x0316, 0x00 },
	{ 0x0317, 0x00 },
	{ 0x0318, 0x00 },
	{ 0x0319, 0x00 },
	{ 0x031A, 0x00 },
	{ 0x031B, 0x00 },
	{ 0x031C, 0x00 },
	{ 0x031D, 0x00 },
	{ 0x031E, 0x00 },
	{ 0x031F, 0x00 },
	{ 0x0320, 0x00 },
	{ 0x0321, 0x00 },
	{ 0x0322, 0x00 },
	{ 0x0323, 0x00 },
	{ 0x0324, 0x00 },
	{ 0x0325, 0x00 },
	{ 0x0326, 0x00 },
	{ 0x0327, 0x00 },
	{ 0x0328, 0x00 },
	{ 0x0329, 0x00 },
	{ 0x032A, 0x00 },
	{ 0x032B, 0x00 },
	{ 0x032C, 0x00 },
	{ 0x032D, 0x00 },
	{ 0x0338, 0x00 },
	{ 0x0339, 0x1F },
	{ 0x033B, 0x00 },
	{ 0x033C, 0x00 },
	{ 0x033D, 0x00 },
	{ 0x033E, 0x00 },
	{ 0x033F, 0x00 },
	{ 0x0340, 0x00 },
	{ 0x0341, 0x00 },
	{ 0x0342, 0x00 },
	{ 0x0343, 0x00 },
	{ 0x0344, 0x00 },
	{ 0x0345, 0x00 },
	{ 0x0346, 0x00 },
	{ 0x0347, 0x00 },
	{ 0x0348, 0x00 },
	{ 0x0349, 0x00 },
	{ 0x034A, 0x00 },
	{ 0x034B, 0x00 },
	{ 0x034C, 0x00 },
	{ 0x034D, 0x00 },
	{ 0x034E, 0x00 },
	{ 0x034F, 0x00 },
	{ 0x0350, 0x00 },
	{ 0x0351, 0x00 },
	{ 0x0352, 0x00 },
	{ 0x0359, 0x00 },
	{ 0x035A, 0x00 },
	{ 0x035B, 0x00 },
	{ 0x035C, 0x00 },
	{ 0x035D, 0x00 },
	{ 0x035E, 0x00 },
	{ 0x035F, 0x00 },
	{ 0x0360, 0x00 },
	{ 0x0487, 0x00 },
	{ 0x0508, 0x00 },
	{ 0x0509, 0x00 },
	{ 0x050A, 0x00 },
	{ 0x050B, 0x00 },
	{ 0x050C, 0x00 },
	{ 0x050D, 0x00 },
	{ 0x050E, 0x00 },
	{ 0x050F, 0x00 },
	{ 0x0510, 0x00 },
	{ 0x0511, 0x00 },
	{ 0x0512, 0x00 },
	{ 0x0513, 0x00 },
	{ 0x0515, 0x00 },
	{ 0x0516, 0x00 },
	{ 0x0517, 0x00 },
	{ 0x0518, 0x00 },
	{ 0x0519, 0x00 },
	{ 0x051A, 0x00 },
	{ 0x051B, 0x00 },
	{ 0x051C, 0x00 },
	{ 0x051D, 0x00 },
	{ 0x051E, 0x00 },
	{ 0x051F, 0x00 },
	{ 0x0521, 0x2B },
	{ 0x052A, 0x00 },
	{ 0x052B, 0x01 },
	{ 0x052C, 0x0F },
	{ 0x052D, 0x03 },
	{ 0x052E, 0x00 },
	{ 0x052F, 0x00 },
	{ 0x0531, 0x00 },
	{ 0x0532, 0x00 },
	{ 0x0533, 0x04 },
	{ 0x0534, 0x00 },
	{ 0x0535, 0x01 },
	{ 0x0536, 0x06 },
	{ 0x0537, 0x00 },
	{ 0x0538, 0x00 },
	{ 0x0539, 0x00 },
	{ 0x053D, 0x0A },
	{ 0x053E, 0x06 },
	{ 0x0589, 0x0C },
	{ 0x058A, 0x00 },
	{ 0x059B, 0x18 },
	{ 0x059D, 0x00 },
	{ 0x059E, 0x00 },
	{ 0x059F, 0x00 },
	{ 0x05A0, 0x00 },
	{ 0x05A1, 0x00 },
	{ 0x05A2, 0x00 },
	{ 0x05A6, 0x00 },
	{ 0x0802, 0x35 },
	{ 0x0803, 0x05 },
	{ 0x0804, 0x01 },
	{ 0x0805, 0x00 },
	{ 0x0806, 0x00 },
	{ 0x0807, 0x00 },
	{ 0x0808, 0x00 },
	{ 0x0809, 0x00 },
	{ 0x080A, 0x00 },
	{ 0x080B, 0x00 },
	{ 0x080C, 0x00 },
	{ 0x080D, 0x00 },
	{ 0x080E, 0x00 },
	{ 0x080F, 0x00 },
	{ 0x0810, 0x00 },
	{ 0x0811, 0x00 },
	{ 0x0812, 0x00 },
	{ 0x0813, 0x00 },
	{ 0x0814, 0x00 },
	{ 0x0815, 0x00 },
	{ 0x0816, 0x00 },
	{ 0x0817, 0x00 },
	{ 0x0818, 0x00 },
	{ 0x0819, 0x00 },
	{ 0x081A, 0x00 },
	{ 0x081B, 0x00 },
	{ 0x081C, 0x00 },
	{ 0x081D, 0x00 },
	{ 0x081E, 0x00 },
	{ 0x081F, 0x00 },
	{ 0x0820, 0x00 },
	{ 0x0821, 0x00 },
	{ 0x0822, 0x00 },
	{ 0x0823, 0x00 },
	{ 0x0824, 0x00 },
	{ 0x0825, 0x00 },
	{ 0x0826, 0x00 },
	{ 0x0827, 0x00 },
	{ 0x0828, 0x00 },
	{ 0x0829, 0x00 },
	{ 0x082A, 0x00 },
	{ 0x082B, 0x00 },
	{ 0x082C, 0x00 },
	{ 0x082D, 0x00 },
	{ 0x082E, 0x00 },
	{ 0x082F, 0x00 },
	{ 0x0830, 0x00 },
	{ 0x0831, 0x00 },
	{ 0x0832, 0x00 },
	{ 0x0833, 0x00 },
	{ 0x0834, 0x00 },
	{ 0x0835, 0x00 },
	{ 0x0836, 0x00 },
	{ 0x0837, 0x00 },
	{ 0x0838, 0x00 },
	{ 0x0839, 0x00 },
	{ 0x083A, 0x00 },
	{ 0x083B, 0x00 },
	{ 0x083C, 0x00 },
	{ 0x083D, 0x00 },
	{ 0x083E, 0x00 },
	{ 0x083F, 0x00 },
	{ 0x0840, 0x00 },
	{ 0x0841, 0x00 },
	{ 0x0842, 0x00 },
	{ 0x0843, 0x00 },
	{ 0x0844, 0x00 },
	{ 0x0845, 0x00 },
	{ 0x0846, 0x00 },
	{ 0x0847, 0x00 },
	{ 0x0848, 0x00 },
	{ 0x0849, 0x00 },
	{ 0x084A, 0x00 },
	{ 0x084B, 0x00 },
	{ 0x084C, 0x00 },
	{ 0x084D, 0x00 },
	{ 0x084E, 0x00 },
	{ 0x084F, 0x00 },
	{ 0x0850, 0x00 },
	{ 0x0851, 0x00 },
	{ 0x0852, 0x00 },
	{ 0x0853, 0x00 },
	{ 0x0854, 0x00 },
	{ 0x0855, 0x00 },
	{ 0x0856, 0x00 },
	{ 0x0857, 0x00 },
	{ 0x0858, 0x00 },
	{ 0x0859, 0x00 },
	{ 0x085A, 0x00 },
	{ 0x085B, 0x00 },
	{ 0x085C, 0x00 },
	{ 0x085D, 0x00 },
	{ 0x085E, 0x00 },
	{ 0x085F, 0x00 },
	{ 0x0860, 0x00 },
	{ 0x0861, 0x00 },
	{ 0x090E, 0x02 },
	{ 0x0943, 0x01 },
	{ 0x0949, 0x00 },
	{ 0x094A, 0x00 },
	{ 0x094E, 0x49 },
	{ 0x094F, 0x02 },
	{ 0x095E, 0x00 },
	{ 0x0A02, 0x00 },
	{ 0x0A03, 0x01 },
	{ 0x0A04, 0x01 },
	{ 0x0A05, 0x01 },
	{ 0x0A14, 0x00 },
	{ 0x0A1A, 0x00 },
	{ 0x0A20, 0x00 },
	{ 0x0A26, 0x00 },
	{ 0x0B44, 0x0F },
	{ 0x0B46, 0x00 },
	{ 0x0B47, 0x0F },
	{ 0x0B48, 0x0F },
	{ 0x0B4A, 0x0E },
	{ 0x0B57, 0x0E },
	{ 0x0B58, 0x01 },
};

static int si5344_write_multiple(struct clk_si5344 *data,
				 const struct si5344_reg_default *values,
				 unsigned int num_values)
{
	unsigned int i;
	int res;

	for (i = 0; i < num_values; ++i) {
		res = regmap_write(data->regmap, values[i].address,
				   values[i].value);
		if (res < 0) {
			dev_err(&data->i2c_client->dev,
				"Failed to write %#x:%#x\n",
				values[i].address, values[i].value);
			return res;
		}
	}

	return 0;
}

static int si5344_send_preamble(struct clk_si5344 *data)
{
	int res;

	res = si5344_write_multiple(data, si5344_preamble,
				    ARRAY_SIZE(si5344_preamble));
	if (res < 0)
		return res;

	msleep(300);

	return 0;
}

/* Perform a soft reset and write post-amble */
static int si5344_send_postamble(struct clk_si5344 *data)
{
	int res;

	res = si5344_write_multiple(data, si5344_postamble,
				    ARRAY_SIZE(si5344_postamble));
	if (res < 0)
		return res;

	msleep(300);

	return 0;
}

/* Pages 0, 1, 2, 3, 9, A, B are valid, so there are 12 pages */
static const struct regmap_range_cfg si5344_regmap_ranges[] = {
	{
		.range_min = 0,
		.range_max = SI5344_REGISTER_MAX,
		.selector_reg = SI5344_PAGE,
		.selector_mask = 0xff,
		.selector_shift = 0,
		.window_start = 0,
		.window_len = 256,
	},
};

static const struct regmap_config si5344_regmap_config = {
	.reg_bits = 8,
	.val_bits = 8,
	.cache_type = REGCACHE_NONE,
	.ranges = si5344_regmap_ranges,
	.num_ranges = ARRAY_SIZE(si5344_regmap_ranges),
	.max_register = SI5344_REGISTER_MAX,
};

static int si5344_probe(struct i2c_client *client,
			const struct i2c_device_id *id)
{
	struct clk_si5344 *data;
	int err;

	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;

	data->i2c_client = client;

	data->regmap = devm_regmap_init_i2c(client, &si5344_regmap_config);
	if (IS_ERR(data->regmap))
		return PTR_ERR(data->regmap);

	i2c_set_clientdata(client, data);

	err = si5344_send_preamble(data);
	if (err < 0) {
		dev_err(&data->i2c_client->dev, "failed to write pre-amble\n");
		return err;
	}

	regcache_cache_only(data->regmap, false);
	/* Write the configuration pairs from the firmware blob */
	err = si5344_write_multiple(data, si5344_reg_defaults,
				    ARRAY_SIZE(si5344_reg_defaults));
	if (err < 0) {
		dev_err(&data->i2c_client->dev,
			"failed to write default registers\n");
		return err;
	}

	err = si5344_send_postamble(data);
	if (err < 0) {
		dev_err(&data->i2c_client->dev, "failed to write post-amble\n");
		return err;
	}

	return 0;
}

static const struct i2c_device_id si5344_id[] = {
	{ "si5344", 4 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, si5344_id);

static const struct of_device_id clk_si5344_of_match[] = {
	{ .compatible = "si5344" },
	{ }
};
MODULE_DEVICE_TABLE(of, clk_si5344_of_match);

static struct i2c_driver si5344_driver = {
	.driver = {
		.name = "si5344",
		.of_match_table = clk_si5344_of_match,
	},
	.probe		= si5344_probe,
	.id_table	= si5344_id,
};

void si5344_exit(void)
{
	i2c_del_driver(&si5344_driver);
}
EXPORT_SYMBOL_GPL(si5344_exit);

int si5344_entry(void)
{
	return i2c_add_driver(&si5344_driver);
}
EXPORT_SYMBOL_GPL(si5344_entry);

MODULE_AUTHOR("Rajesh Gugulothu <gugulot@xilinx.com>");
MODULE_DESCRIPTION("Si5344 driver");
MODULE_LICENSE("GPL");
