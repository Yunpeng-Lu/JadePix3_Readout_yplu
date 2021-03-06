----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/19/2020 03:17:24 PM
-- Design Name: 
-- Module Name: ipbus_dac70004_device - behv
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;

entity ipbus_dac70004_device is
  port (
    ipb_clk : in  std_logic;
    ipb_rst : in  std_logic;
    ipb_in  : in  ipb_wbus;
    ipb_out : out ipb_rbus;

    DAC_BUSY : in  std_logic;
    DAC_WE   : out std_logic;
    DAC_DATA : out std_logic_vector(31 downto 0)
    );
end ipbus_dac70004_device;


architecture behv of ipbus_dac70004_device is
  constant N_STAT : integer := 1;
  constant N_CTRL : integer := 2;
  signal stat     : ipb_reg_v(N_STAT-1 downto 0);
  signal ctrl     : ipb_reg_v(N_CTRL-1 downto 0);

begin
  inst_ipbus_ctrlreg : entity work.ipbus_ctrlreg_v
    generic map(
      N_CTRL     => N_CTRL,
      N_STAT     => N_STAT,
      SWAP_ORDER => true
      )
    port map(
      clk       => ipb_clk,
      reset     => ipb_rst,
      ipbus_in  => ipb_in,
      ipbus_out => ipb_out,
      d         => stat,
      q         => ctrl
      );

  stat(0)(0) <= DAC_BUSY;

  DAC_WE   <= ctrl(0)(0);
  DAC_DATA <= ctrl(1);


end behv;
