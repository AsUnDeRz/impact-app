const mongoose = require("mongoose");

const dataSchema = new mongoose.Schema({
  num: {
    type: "String",
  },
  name: {
    type: "String",
  },
  img: {
    type: "String",
  },
  type: {
    type: ["String"],
  },
  height: {
    type: "String",
  },
  weight: {
    type: "String",
  },
  candy: {
    type: "String",
  },
  egg: {
    type: "String",
  },
  multipliers: {
    type: ["Number"],
  },
  weaknesses: {
    type: ["String"],
  },
  candy_count: {
    type: "Number",
  },
  spawn_chance: {
    type: "Number",
  },
  avg_spawns: {
    type: "Number",
  },
  spawn_time: {
    type: "String",
  },
  prev_evolution: {
    type: ["Mixed"],
  },
  next_evolution: {
    type: ["Mixed"],
  },
});

module.exports = mongoose.model("Pokemon", dataSchema);
