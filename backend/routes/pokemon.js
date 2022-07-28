const express = require("express");

const router = express.Router();
const Model = require("../models/pokemon");

//Create
router.post("/collected", async (req, res) => {
  console.log(req.body);
  try {
    const docCount = await Model.countDocuments({}).exec();
    console.log(docCount);
    var lastId = docCount + 1;
    req.body.id = lastId;
    req.body.num = lastId.toString();
    const data = new Model(req.body);
    data.save((err, dataToSave) => {
      console.log(dataToSave._id);
      res.status(200).json(dataToSave);
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({ message: error.message });
  }
});

//Get all Method
router.get("/getAll", async (req, res) => {
  try {
    const pageNumber = req.query.page;
    const nPerPage = req.query.limit;
    const data = await Model.find()
      .sort({ id: 1 })
      .skip(pageNumber > 0 ? (pageNumber - 1) * nPerPage : 0)
      .limit(nPerPage);
    res.json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//Get by ID Method
router.get("/getPokemon/:id", async (req, res) => {
  try {
    const data = await Model.findById(req.params.id);
    res.json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//Update Pokemon by ID Method
router.put("/update/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const updatedData = req.body;
    const options = { new: true };

    const result = await Model.findByIdAndUpdate(id, updatedData, options);

    res.send(result);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

//Delete by ID Method
router.delete("/delete/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const data = await Model.findByIdAndDelete(id);
    res.send(`Document with ${data.name} has been deleted..`);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

module.exports = router;
