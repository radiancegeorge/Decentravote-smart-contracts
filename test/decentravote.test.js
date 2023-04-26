const decentravote = artifacts.require("DecentraVote");
const dvt = artifacts.require("DVT");
const test = artifacts.require("Test");

contract("Testing the decentraVote functions", (accounts) => {
  it("should add dvt as a supported token for payment", async () => {
    const dvtInstance = await dvt.deployed();
    const decentravoteInstance = await decentravote.deployed();
    await decentravoteInstance.addTokenCharges(dvtInstance.address, 10);
  });

  it("dvt should give decentravote allowance to spend", async () => {
    const dvtInstance = await dvt.deployed();
    const decentravoteInstance = await decentravote.deployed();
    await dvtInstance.approve(
      decentravoteInstance.address,
      "1000000000000000000000"
    );
  });

  it("decentravote add test project", async () => {
    const decentravoteInstance = await decentravote.deployed();
    const testInstance = await test.deployed();
    await decentravoteInstance.listProject(testInstance.address);
  });

  it("create a poll with dvt token", async () => {
    const dvtInstance = await dvt.deployed();
    const decentravoteInstance = await decentravote.deployed();
    const testInstance = await test.deployed();

    console.log(await dvtInstance.balanceOf(accounts[0]));

    await decentravoteInstance.createPoll(
      dvtInstance.address,
      "0x68656c6c6f2064656172",
      "awesome description",
      ["0x68656c6c6f2064656172", "0x68656c6c6f2064656172"],
      testInstance.address
    );

    console.log(await dvtInstance.balanceOf(accounts[0]));

    console.log(
      await decentravoteInstance.getProjectPolls(testInstance.address)
    );
  });
});
