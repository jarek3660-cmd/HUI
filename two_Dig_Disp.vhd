----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2026 01:49:35 PM
-- Design Name: 
-- Module Name: two_Dig_Disp - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity two_Dig_Disp is
    Port ( Clk: in STD_LOGIC;
           USB_Clk, USB_Data : in STD_LOGIC_VECTOR (3 downto 0);
           Cathodes : out STD_LOGIC_VECTOR (7 downto 0));
end two_Dig_Disp;

architecture Behavioral of two_Dig_Disp is

component Frequency_Divider is
    Port ( Clock_System : in STD_LOGIC;
           Clock_1Hz : out STD_LOGIC);
end component; 

component hexDisp is
  Port (clk : in STD_LOGIC;
        input : in STD_LOGIC_VECTOR(3 downto 0);
        Cathode_7SD, Anode_7SD : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal Slow_Clock : STD_LOGIC;

begin

fd: Frequency_Divider Port Map ( Clock_System => Clk,
           Clock_1Hz => Slow_Clock);
sevenValues: hexDisp Port Map(Slow_Clock,
                              USB_CLk,
                              Cathodes);

sevenValues2: hexDisp Port Map(Slow_Clock,
                              USB_Data,
                              Cathodes);
end Behavioral;
