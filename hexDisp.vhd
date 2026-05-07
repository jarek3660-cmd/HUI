library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hexDisp is
  Port (
    clk   : in  STD_LOGIC;
    input : in  STD_LOGIC_VECTOR(3 downto 0);
    seg   : out STD_LOGIC_VECTOR(7 downto 0)
  );
end hexDisp;

architecture Behavioral of hexDisp is

  component ROM1
    port (
      a    : in  STD_LOGIC_VECTOR(3 downto 0);
      clk  : in  STD_LOGIC;
      qspo : out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;

begin

  sevenSegValues : ROM
    port map (
      a    => input,
      clk  => clk,
      qspo => seg
    );

end Behavioral;
