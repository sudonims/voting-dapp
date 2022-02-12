import React from "react";
import {
  Box,
  Flex,
  Avatar,
  Button,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  useColorModeValue,
  Stack,
  useColorMode,
  Center,
  useToast,
} from "@chakra-ui/react";
import { MoonIcon, SunIcon } from "@chakra-ui/icons";

import Web3 from "web3";
import Web3Context from "../helpers/web3Context";
import voterData from "../src/contracts/VoterData.json";
import { VOTER_DATA_ADDRESS } from "../helpers/constants";

export default function Nav() {
  const { colorMode, toggleColorMode } = useColorMode();
  const toast = useToast();
  const { web3, address, updateAddress, updateWeb3 } =
    React.useContext(Web3Context);

  const signin = async () => {
    if (window.ethereum) {
      var accounts = await ethereum.request({ method: "eth_requestAccounts" });
      updateAddress(accounts[0]);
      let w3 = new Web3(ethereum);
      updateWeb3(w3);
      toast({
        title: "Sign in Success.",
        description: "You can vote now",
        status: "success",
        duration: 5000,
        isClosable: true,
      });
    } else {
      console.log("Please install MetaMask");
      toast({
        title: "Unsupported",
        description:
          "Please try from web3 supported browser. Install metamask if needed",
        duration: 5000,
        isClosable: true,
      });
    }
  };

  const register = async () => {
    try {
      let contract = new web3.eth.Contract(voterData.abi, VOTER_DATA_ADDRESS);
      var result = await contract.methods
        .registerNewVoter("bcde", address)
        .send({
          from: address,
        });

      if ("registrationDone" in result.events) {
        toast({
          title: "Voter Registered",
          description: "Successfully registered with contract",
          status: "success",
          duration: 5000,
          isClosable: true,
        });
      }
    } catch (err) {
      console.log(err);
      toast({
        title: "Error Occured",
        description: "Couldn't register voter.",
        status: "error",
        duration: 5000,
        isClosable: true,
      });
    }
  };

  const logout = () => {
    updateAddress(null);
    updateWeb3(null);
  };

  return (
    <>
      <Box bg={useColorModeValue("gray.100", "gray.900")} px={4}>
        <Flex h={16} alignItems={"center"} justifyContent={"space-between"}>
          <Box>Logo</Box>

          <Flex alignItems={"center"}>
            <Stack direction={"row"} spacing={7}>
              <Button onClick={toggleColorMode}>
                {colorMode === "light" ? <MoonIcon /> : <SunIcon />}
              </Button>

              <Menu>
                <MenuButton
                  as={Button}
                  rounded={"full"}
                  variant={"link"}
                  cursor={"pointer"}
                  minW={0}
                >
                  <Avatar
                    size={"sm"}
                    src={"https://avatars.dicebear.com/api/male/username.svg"}
                  />
                </MenuButton>
                {address ? (
                  <MenuList alignItems={"center"}>
                    <br />
                    <Center>
                      <Avatar
                        size={"2xl"}
                        src={
                          "https://avatars.dicebear.com/api/male/username.svg"
                        }
                      />
                    </Center>
                    <br />
                    <Center padding={2}>
                      <p>{address}</p>
                    </Center>
                    <br />
                    <MenuItem onClick={register}>Register for Voting</MenuItem>
                    <br />
                    <MenuItem onClick={logout}>Logout</MenuItem>
                  </MenuList>
                ) : (
                  <MenuList alignItems="center">
                    <br />
                    <MenuItem onClick={signin}>Sign in with metamask</MenuItem>
                    <br />
                    <MenuItem>Create New Account</MenuItem>
                  </MenuList>
                )}
              </Menu>
            </Stack>
          </Flex>
        </Flex>
      </Box>
    </>
  );
}
