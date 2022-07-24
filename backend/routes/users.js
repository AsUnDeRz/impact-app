const express = require("express");

const router = express.Router();
const Model = require("../models/user");

router.post("/verify", async (req, res) => {
  try {
    const data = await Model.findOne({
      email: req.body.email,
      first_name: req.body.first_name,
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
