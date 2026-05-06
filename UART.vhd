----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2026 03:01:19 PM
-- Design Name: 
-- Module Name: UART - Behavioral
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

entity UART is
    Port ( USB_CLK, USB_DATA : in STD_LOGIC;
           LowerHalf, HigherHalf : out STD_LOGIC_VECTOR(3 downto 0));
end UART;

architecture Behavioral of UART is
    signal bitCount : integer range 0 to 100 := 0;
    signal scancodeReady : STD_LOGIC := '0'; 
    signal scancode : STD_LOGIC_VECTOR(7 downto 0);
    signal breakRecieved : STD_LOGIC := '0';
    
begin
    
    keyboard_scan_ready_enable : process(USB_CLK) is 
    begin
        if falling_edge(USB_CLK) then
            if bitCount = 0 and USB_DATA = '0' then
                scancodeReady <= '0';
                bitCount <= bitCount +1;
            elsif bitCount > 0 and bitCount < 9 then
                scancode <= USB_DATA & scancode(7 downto 1);
                bitCount <= bitCount +1; 
            elsif bitCount = 9 then
                bitCount <= bitCount + 1;
            elsif bitCount = 10 then 
                scancodeReady <= '1';
                bitCount <= 0;
            end if;
        end if;
    end process keyboard_scan_ready_enable;
    
    scan_keyboard : process(scancodeReady, scancode) is 
    begin
        if rising_edge(scancodeReady) then
            if breakRecieved = '1' then 
                breakRecieved <= '0';
            else 
                 if scancode = "11110000" then 
                    breakRecieved <= '1';
                 end if;
             end if;
         end if;
     end process;
     
     LowerHalf <= scancode (3 downto 0);
     HigherHalf <= scancode (7 downto 4);

end Behavioral;