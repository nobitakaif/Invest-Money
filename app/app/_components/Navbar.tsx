"use client"
import { ConnectButton, useActiveAccount } from "thirdweb/react"
import { client } from "../client"
import Link from "next/link"


export default function Navbar(){
    const activeAccount = useActiveAccount()
    return <div className="w-full h-18 flex items-center justify-center">
        <div className="flex items-center justify-around bg-gray-500 text-black w-[1500] rounded-2xl fixed h-[10%] mt-5">
            <div>
                <span className="font-bold ">Invest-Money</span>
            </div>
            <div className="flex justify-center items-center">
                <div className=" rounded-2xl w-56">
                    <ConnectButton client={client} />
                </div>
                {activeAccount ? <div className="bg-black w-28 h-10 rounded-2xl p-2 text-gray-300 text-center">
                    <Link href={`/dashboard/${activeAccount?.address}`}>
                        <span className="">Dashboard</span>
                    </Link>
                </div> : ""}
            </div>
        </div>
        
    </div>
}