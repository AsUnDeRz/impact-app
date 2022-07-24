const mongoose = require("mongoose");

const dataSchema = new mongoose.Schema({
  email: {
    required: true,
    type: String,
  },
  first_name: {
    required: true,
    type: String,
  },
  last_name: {
    required: true,
    type: String,
  },
  avatar: {
    type: String,
  },
});

module.exports = mongoose.model("User", dataSchema);
