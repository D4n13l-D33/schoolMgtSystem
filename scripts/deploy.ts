import { ethers } from "hardhat";

async function main() {
   
  const schoolMgt = await ethers.deployContract("SchoolManagmentSystem");

  await schoolMgt.waitForDeployment();

  console.log(
    `School Management System deployed to ${schoolMgt.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});