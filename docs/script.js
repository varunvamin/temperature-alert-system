document.addEventListener('DOMContentLoaded', () => {
    const visualizer = document.getElementById('wave-visualizer');
    const btn = document.getElementById('trigger-sim-btn');
    const NUM_BARS = 30;
    
    // Initialize bars
    for(let i=0; i<NUM_BARS; i++) {
        const bar = document.createElement('div');
        bar.className = 'bar';
        bar.style.height = `${20 + Math.random() * 20}%`;
        visualizer.appendChild(bar);
    }
    
    let isSimulating = false;
    
    btn.addEventListener('click', () => {
        if(isSimulating) return;
        isSimulating = true;
        btn.textContent = "Simulating Spike...";
        
        const bars = document.querySelectorAll('.bar');
        
        // Create a temperature spike moving across
        bars.forEach((bar, index) => {
            setTimeout(() => {
                // The spike area
                if (index > 10 && index < 20) {
                    bar.style.height = `${80 + Math.random() * 15}%`;
                    
                    // Simulate debouncing logic - alerts after sustained threshold
                    if (index > 13) {
                        bar.classList.add('alert');
                    }
                } else {
                    bar.style.height = `${20 + Math.random() * 20}%`;
                    bar.classList.remove('alert');
                }
            }, index * 100);
        });
        
        setTimeout(() => {
            isSimulating = false;
            btn.textContent = "Simulate Spike";
            // Return to normal
            bars.forEach((bar) => {
                bar.style.height = `${20 + Math.random() * 20}%`;
                bar.classList.remove('alert');
            });
        }, NUM_BARS * 100 + 2000);
    });
});
