library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_ProjectD is
    Port (
        clk       : in  STD_LOGIC;
        usb_clk   : in  STD_LOGIC;
        usb_data  : in  STD_LOGIC;
        an        : out STD_LOGIC_VECTOR(1 downto 0);
        seg       : out STD_LOGIC_VECTOR(7 downto 0)
    );
end top_ProjectD;

architecture Behavioral of top_ProjectD is

    component UART is
        Port (
            USB_CLK     : in STD_LOGIC;
            USB_DATA    : in STD_LOGIC;
            LowerHalf   : out STD_LOGIC_VECTOR(3 downto 0);
            HigherHalf  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component two_Dig_Disp is
        Port (
            clk       : in  STD_LOGIC;
            digit_hi  : in  STD_LOGIC_VECTOR(3 downto 0);
            digit_lo  : in  STD_LOGIC_VECTOR(3 downto 0);
            an        : out STD_LOGIC_VECTOR(1 downto 0);
            seg       : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal digit_hi : STD_LOGIC_VECTOR(3 downto 0);
    signal digit_lo : STD_LOGIC_VECTOR(3 downto 0);

begin

    u_uart : UART
        port map (
            USB_CLK    => usb_clk,
            USB_DATA   => usb_data,
            LowerHalf  => digit_lo,
            HigherHalf => digit_hi
        );

    u_disp : two_Dig_Disp
        port map (
            clk      => clk,
            digit_hi => digit_hi,
            digit_lo => digit_lo,
            an       => an,
            seg      => seg
        );

end Behavioral;
