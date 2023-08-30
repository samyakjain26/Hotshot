const express = require('express');
const multer = require('multer');

//Stationary Routes
const {
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  authenticateStationaryOwner
} = require('../Middlewares/verifyToken');
const Stationary = require('../Models/Stationary');
const jwt = require('jsonwebtoken');

const router = express.Router();
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//GET ALL SHOPS BY QUERY
router.get('/stationary/stationaryShop', async (req, res) => {
  try {
    var obj = {};
    if (req.query.status) obj.status = req.query.status;
    if (req.query.name) {
      obj.StationaryName = {
        "$regex": `${req.query.name}`, "$options": 'i'
      }
    }
    const stationaries = await Stationary.find(obj);
    return res.json(stationaries);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//GET A SHOP BY ID
router.get('/stationary/stationaryShop/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const stationary = await Stationary.findById(id);
    if(!stationary){
      return res.status(400).json('Wrong shop id!');
    }
    return res.json(stationary);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//CREATE A SHOP
router.post('/stationary/stationaryShop', upload.single('pic'), async (req, res) => {
  try {
    var existingStat = await Stationary.findOne({ email: req.body.email });
    if (!existingStat) {
      const stationary = new Stationary(req.body);
      if (req.file) {
        stationary.pic.data = req.file.buffer;
        stationary.pic.contentType = req.file.mimetype;
      }
      existingStat = stationary;
      stationary.save();
    }
    jwt.sign(
      { isowner: true, id: existingStat._id },
      process.env.JWT_SEC,
      (err, token) => {
        res.header('token', `${token}`);
        return res.json(existingStat);
      }
    );
  } catch (err) {
    res.status(400).send(err.message);
  }
});

//LOGIN FOR STATIONARY
router.post('/stationary/stationaryShop/login', async (req, res) => {
  try {
    const stationary = await Stationary.findOne({ email: req.body.email });
    if (!stationary) {
      return res.status(403).json({ message: "You are not registered" });
    }
    else {
      jwt.sign(
        { isowner: true, id: stationary._id },
        process.env.JWT_SEC,
        (err, token) => {
          res.header('token', `${token}`);
          return res.json(stationary);
        }
      );
    }
  }
  catch (err) {
    res.status(403).send(err.message);
  }
})

//UPDATE A SHOP BY ID
router.put('/stationary/stationaryShop/:statid',verifyToken,authenticateStationaryOwner,async (req, res) => {
    try {
      const stationary = await Stationary.findByIdAndUpdate(
        req.params.statid,
        req.body,
        { runValidators: true, new: true }
      );
      return res.json(stationary);
    } catch (err) {
      return res.status(400).send(err.message);
    }
  }
);

//DELETE A SHOP
router.delete('/stationary/stationaryShop/:statid',verifyToken,authenticateStationaryOwner,async (req, res) => {
    try {
      await Stationary.findByIdAndDelete(req.params.statid);
      return res.status(200).json('Stationary shop has been deleted!');
    } catch (err) {
      return res.status(500).json(err);
    }
  }
);

module.exports = router;
