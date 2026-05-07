library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_Dig_Disp is
    Port (
        clk       : in  STD_LOGIC;
        digit_hi  : in  STD_LOGIC_VECTOR(3 downto 0);
        digit_lo  : in  STD_LOGIC_VECTOR(3 downto 0);
        an        : out STD_LOGIC_VECTOR(1 downto 0);
        seg       : out STD_LOGIC_VECTOR(7 downto 0)
    );
end two_Dig_Disp;

architecture Behavioral of two_Dig_Disp is

    component Frequency_Divider is
        Port (
            Clock_System : in  STD_LOGIC;
            Clock_2ms    : out STD_LOGIC
        );
    end component;

    component hexDisp is
        Port (
            clk   : in  STD_LOGIC;
            input : in  STD_LOGIC_VECTOR(3 downto 0);
            seg   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal tick_2ms      : STD_LOGIC;
    signal anode_state   : STD_LOGIC := '0';
    signal current_digit : STD_LOGIC_VECTOR(3 downto 0);

begin

    u_div : Frequency_Divider
        port map (
            Clock_System => clk,
            Clock_2ms    => tick_2ms
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if tick_2ms = '1' then
                anode_state <= not anode_state;
            end if;
        end if;
    end process;

    process(anode_state, digit_hi, digit_lo)
    begin
        if anode_state = '0' then
            current_digit <= digit_lo;
            an <= "10";
        else
            current_digit <= digit_hi;
            an <= "01";
        end if;
    end process;

    u_hex : hexDisp
        port map (
            clk   => clk,
            input => current_digit,
            seg   => seg
        );

end Behavioral;
