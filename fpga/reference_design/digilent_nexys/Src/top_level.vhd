----------------------------------------------------------------------------------
-- Company: Evan Stoddard
-- Engineer: Evan Stoddard
-- 
-- Create Date: 11/27/2024 07:45:09 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: FPGA VGA Card (Nexys 4 Reference Design)
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

entity top_level is
    Port (
        xCI_CLK_100_MHz: in std_logic;
        
        xVO_VGA_R: out std_logic_vector(3 downto 0);
        xVO_VGA_G: out std_logic_vector(3 downto 0);
        xVO_VGA_B: out std_logic_vector(3 downto 0);
        
        xSO_VGA_HS: out std_logic;
        xSO_VGA_VS: out std_logic
    );
end top_level;

architecture Behavioral of top_level is
    
begin

xVO_VGA_R <= "0000";
xVO_VGA_G <= "0000";
xVO_VGA_B <= "0000";

xSO_VGA_HS <= xCI_CLK_100_MHz;
xSO_VGA_VS <= xCI_CLK_100_MHz;
    
end Behavioral;
