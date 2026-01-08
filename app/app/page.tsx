
"use client"
import { getContract } from "thirdweb";
import Navbar from "./_components/Navbar";
import { client } from "./client";
import { baseSepolia } from "thirdweb/chains";
import { useReadContract } from "thirdweb/react";

export default function Home() {
  const contract = getContract({
    address : "0x4daE06AC2bB887247Adc110Ba28BB0f35f07BFF2",
    client : client,
    chain : baseSepolia,
  })

  const {data : campaigns, isLoading} = useReadContract({
    contract : contract,
    method : "function fund() view returns ((address campaignAddress, address owner, string name, uint256 creationTime)[)",
    params : []
  })

  console.log(campaigns)
  
  return (
    <div className="h-screen w-full flex justify-center">
      <div className="h-17 w-[50%]    mt-5 rounded-2xl ">
          <h1 className="text-4xl font-bold">Invest:</h1>
      </div>
    </div>
    // <Navbar/>
  );
}
