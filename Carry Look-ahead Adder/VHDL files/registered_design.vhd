----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2018 01:41:14 PM
-- Design Name: 
-- Module Name: registered_design - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY registered_design IS
    PORT (
        x_128 : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        y_128 : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
        clk : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
        c_out : OUT STD_LOGIC);
END registered_design;

ARCHITECTURE Behavioral OF registered_design IS

    COMPONENT carry_look_ahead IS
        PORT (
            x_128 : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
            y_128 : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
            sum : OUT STD_LOGIC_VECTOR (127 DOWNTO 0);
            c_out_128 : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT registers IS
        PORT (
            clk : IN STD_LOGIC;
            reg_in : IN STD_LOGIC_VECTOR (127 DOWNTO 0);
            reg_out : OUT STD_LOGIC_VECTOR (127 DOWNTO 0));
    END COMPONENT;
    --signal x_128 : STD_LOGIC_VECTOR(127 downto 0);
    --signal y_128 : STD_LOGIC_VECTOR(127 downto 0);
    --signal sum : STD_LOGIC_VECTOR(127 downto 0);
    --signal c_out_128 : STD_LOGIC;

    SIGNAL x_128_r_1 : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL y_128_r_1 : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL sum_128_r_1 : STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL c_out_r_1 : STD_LOGIC;

    ATTRIBUTE DONT_TOUCH : STRING;
    ATTRIBUTE DONT_TOUCH OF reg_x : LABEL IS "YES";
    ATTRIBUTE DONT_TOUCH OF reg_y : LABEL IS "YES";
    ATTRIBUTE DONT_TOUCH OF reg_s : LABEL IS "YES";
    ATTRIBUTE DONT_TOUCH OF cla : LABEL IS "YES";
BEGIN

    reg_x : registers PORT MAP(
        clk => clk,
        reg_in => x_128,
        reg_out => x_128_r_1
    );

    reg_y : registers PORT MAP(
        clk => clk,
        reg_in => y_128,
        reg_out => y_128_r_1
    );

    reg_s : registers PORT MAP(
        clk => clk,
        reg_in => sum_128_r_1,
        reg_out => sum
    );

    cla : carry_look_ahead PORT MAP(
        x_128 => x_128_r_1,
        y_128 => y_128_r_1,
        sum => sum_128_r_1,
        c_out_128 => c_out_r_1
    );
    --process(clk) is
    --begin
    --    if rising_edge(clk) then
    --        x_128_r_1 <= x_128;
    --        y_128_r_1 <= y_128;

    --        sum <= sum_128_r_1;
    --        c_out <= c_out_r_1;
    --    end if;
    --end process;
END Behavioral;