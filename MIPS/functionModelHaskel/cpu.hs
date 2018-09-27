-- 32 bits MIPS processor
{-# LANGUAGE RecordWildCards #-}
module Main where
import Data.Array

data Instruction a 
    = Instruction_R_type { op :: a, rs :: a, rt :: a, rd :: a, shamt :: a, funct :: a }
    | Instruction_I_type { op :: a, rs :: a, rt :: a, imm :: a }
    | Instruction_J_type { op :: a, addr :: a }
    deriving( Show, Eq )

data State a = State { pc :: a, register :: Array Int a, localMemory :: Array Int a, instractionMemory :: [Instruction a] } deriving ( Show, Eq ) 

cpuStateDefault = State {
                            pc                = 0x00
                        ,   register          = array (0,31) $ zip [0..31] (repeat 0)
                        ,   localMemory       = array (0,255) $ zip [0..255] (repeat 0)
                        ,   instractionMemory = commands
                        } 

commands = [ 
            ( Instruction_I_type 0x08 0x01 0x00 0x04 )
        ,   ( Instruction_I_type 0x08 0x02 0x00 0x05 )
        ,   ( Instruction_R_type 0x00 0x10 0x11 0x13 0x00 0x20 )
        ,   ( Instruction_J_type 0x02 0x00 )
           ]

cpu st@State{..} command | ( op command ) == 0x00 = case funct command of 
                            0x20 -> st{ register = register // [(rd command, (register ! rs command) + (register ! rt command) )] }            -- ADD
                            0x22 -> st{ register = register // [(rd command, (register ! rs command) - (register ! rt command) )] }            -- SUB
                         | ( op command ) == 0x08 = st{ register = register // [( rt command, (register ! rs command) + (imm command) )] }     -- ADDI 
                         | ( op command ) == 0x23 = st{ register = register // [( rt command, localMemory ! (imm command + rs command) )] }    -- LW
                         | ( op command ) == 0x2b = st{ localMemory = localMemory // [( (imm command + rs command), register ! rt command )] } -- SW
                         | ( op command ) == 0x02 = st{ pc = addr command }                                                                    -- JUMP

printList :: Show a => [a] -> IO ()
printList = mapM_ (putStrLn . show)

applyState st@State{ pc = pc, instractionMemory = instractionMemory } = let state' = cpu st{pc = pc + 1} (instractionMemory !! pc)
                                               in state' : applyState state' 

main = do printList $ take 10 $ applyState cpuStateDefault