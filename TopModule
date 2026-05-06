library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk        : in  STD_LOGIC;
        usb_clk    : in  STD_LOGIC;
        usb_data   : in  STD_LOGIC;
        an         : out STD_LOGIC_VECTOR(1 downto 0);
        seg        : out STD_LOGIC_VECTOR(7 downto 0)
    );
end top_ProjectD;

architecture Behavioral of top_ProjectD is

    component keyboard_ifc is
        Port (
            usb_clk  : in  STD_LOGIC;
            usb_data : in  STD_LOGIC;
            hex_hi   : out STD_LOGIC_VECTOR(3 downto 0);
            hex_lo   : out STD_LOGIC_VECTOR(3 downto 0)
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

    u_kbd : keyboard_ifc
        port map (
            usb_clk  => usb_clk,
            usb_data => usb_data,
            hex_hi   => digit_hi,
            hex_lo   => digit_lo
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
