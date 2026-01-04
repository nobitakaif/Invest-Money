// import Image from "next/image";
"use client"
import { ConnectButton } from "thirdweb/react";
import { client } from "./provider"


console.log(`client id ${process.env.NEXT_PUBLIC_THIRDWEB_CLIENT_ID}`)
export default function Home() {
  
  return (
      <div>
        <ConnectButton  client={client}/>
      </div>
  );
}
