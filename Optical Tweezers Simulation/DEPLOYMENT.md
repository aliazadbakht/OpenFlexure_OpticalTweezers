# Deploying the Optical Tweezers Simulation to GitHub Pages

This guide will help you deploy your interactive optical tweezers simulation to GitHub Pages so anyone can access it via a web browser.

## 🚀 Quick Deployment Steps

### Option 1: Deploy from the Repository Root (Recommended)

1. **Move the HTML file to the repository root:**
   ```bash
   cp "Optical Tweezers Simulation/index.html" index.html
   ```

2. **Commit and push to GitHub:**
   ```bash
   git add index.html
   git commit -m "Add PyScript optical tweezers simulation for GitHub Pages"
   git push origin main
   ```

3. **Enable GitHub Pages:**
   - Go to your repository on GitHub: `https://github.com/yourusername/OpenFlexureOT`
   - Click **Settings** → **Pages** (in the left sidebar)
   - Under **Source**, select **Deploy from a branch**
   - Under **Branch**, select `main` and `/ (root)`
   - Click **Save**

4. **Access your simulation:**
   - GitHub will provide a URL like: `https://yourusername.github.io/OpenFlexureOT/`
   - Wait 1-2 minutes for deployment to complete
   - Visit the URL to see your simulation!

### Option 2: Deploy from a Specific Folder

1. **Create a `docs` folder and move the file:**
   ```bash
   mkdir -p docs
   cp "Optical Tweezers Simulation/index.html" docs/index.html
   ```

2. **Commit and push:**
   ```bash
   git add docs/
   git commit -m "Add simulation to docs folder for GitHub Pages"
   git push origin main
   ```

3. **Enable GitHub Pages:**
   - Go to **Settings** → **Pages**
   - Select branch `main` and folder `/docs`
   - Click **Save**

4. **Access:** `https://yourusername.github.io/OpenFlexureOT/`

### Option 3: Deploy to a Separate Branch (gh-pages)

1. **Create and switch to gh-pages branch:**
   ```bash
   git checkout -b gh-pages
   ```

2. **Keep only the HTML file:**
   ```bash
   cp "Optical Tweezers Simulation/index.html" index.html
   git add index.html
   git commit -m "Initial GitHub Pages deployment"
   git push origin gh-pages
   ```

3. **Switch back to main:**
   ```bash
   git checkout main
   ```

4. **Enable GitHub Pages:**
   - Go to **Settings** → **Pages**
   - Select branch `gh-pages` and `/ (root)`
   - Click **Save**

## 📝 Important Notes

### First Load Time
- **Initial load takes 10-30 seconds** because PyScript downloads Python runtime and libraries
- Subsequent interactions are fast
- This is normal for PyScript applications

### Browser Compatibility
- Works best in **Chrome, Firefox, Edge, Safari** (latest versions)
- Requires JavaScript enabled
- Some older browsers may not support WebAssembly

### File Size
- The HTML file is self-contained (no external dependencies except PyScript CDN)
- All Python code is embedded in the HTML
- No need to upload additional files

## 🔧 Customization

### Update GitHub Link
In `index.html`, find this line and update with your actual GitHub username:
```html
<p>Built with PyScript | <a href="https://github.com/yourusername/OpenFlexureOT" target="_blank">View on GitHub</a></p>
```

Change `yourusername` to your actual GitHub username.

### Change Simulation Parameters
Edit the parameters in the `OpticalTrapSimulation.__init__()` method:
- `self.power` - Laser power (5.0e-3 = 5 mW)
- `self.wavelength` - Laser wavelength (635e-9 = 635 nm)
- `self.d_p` - Particle diameter (4.0e-6 = 4 µm)
- `self.stiffness` - Trap stiffness (1.5e-6 N/m)

## 🐛 Troubleshooting

### Simulation doesn't load
- Check browser console for errors (F12)
- Ensure you have a stable internet connection (PyScript loads from CDN)
- Clear browser cache and reload

### Simulation is slow
- This is expected on first load
- Close other browser tabs to free up memory
- Try a different browser (Chrome usually performs best)

### 404 Error on GitHub Pages
- Wait 2-5 minutes after enabling Pages
- Check that `index.html` is in the correct location
- Verify the branch/folder settings in GitHub Pages settings

## 🌐 Sharing Your Simulation

Once deployed, share your simulation with:
- **Direct link:** `https://yourusername.github.io/OpenFlexureOT/`
- **QR Code:** Generate a QR code pointing to your URL
- **Embed:** Can be embedded in other websites using an iframe

## 📚 Additional Resources

- [PyScript Documentation](https://pyscript.net/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Original Simulation](../Optical%20Tweezers%20Simulation/opticaltweezers_simulation.py)

## ✨ What's Different from the Python Version?

The PyScript version:
- ✅ Runs in any web browser (no Python installation needed)
- ✅ Can be hosted on GitHub Pages for free
- ✅ Same physics simulation and interactivity
- ✅ Same visual appearance
- ⏱️ Slower initial load time (10-30 seconds)
- 🌐 Requires internet connection for first load

## 🎓 For Academic Use

If using this simulation for teaching or research:
1. Consider adding a citation/acknowledgment section
2. You can modify the instructions for your specific use case
3. The simulation accurately represents Brownian motion in optical traps
4. Parameters are based on realistic experimental values

---

**Need help?** Open an issue on the GitHub repository!
