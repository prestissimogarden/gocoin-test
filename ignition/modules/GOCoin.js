const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("GOCoin", (m) => {
  const gocoin = m.contract("GOCoin");
  return { gocoin };
});