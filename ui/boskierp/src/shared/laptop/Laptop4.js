import React, { useRef, useState } from "react";
import { Canvas } from "@react-three/fiber";
import { OrbitControls, useGLTF } from "@react-three/drei";
import * as THREE from "three";

function Weapon({ onPartClick }) {
  let src = `${process.env.PUBLIC_URL}/dddd.glb`;
  const { scene } = useGLTF(src); // Load your 3D model here
  const [isDragging, setIsDragging] = useState(false);
  const [draggedPart, setDraggedPart] = useState(null);
  const raycaster = new THREE.Raycaster();
  const mouse = new THREE.Vector2();

  const handlePointerDown = (event) => {
    event.stopPropagation();
    const intersection = getIntersection(event);
    if (intersection) {
      setIsDragging(true);
      setDraggedPart(intersection.object);
    }
  };

  const handlePointerUp = () => {
    setIsDragging(false);
    setDraggedPart(null);
  };

  const handlePointerMove = (event) => {
    if (!isDragging || !draggedPart) return;
    const intersection = getIntersection(event);
    if (intersection) {
      draggedPart.position.copy(intersection.point);
    }
  };

  const getIntersection = (event) => {
    mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
    mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;

    raycaster.setFromCamera(mouse, event.camera);
    // Set a plane for dragging (can adjust if needed)
    const plane = new THREE.Plane(new THREE.Vector3(0, 0, 0), 0);
    const intersectPoint = new THREE.Vector3();
    raycaster.ray.intersectPlane(plane, intersectPoint);

    // Find the intersected object
    const intersects = raycaster.intersectObjects(scene.children, true);
    if (intersects.length > 0) {
      return intersects[0]; // Return the intersection point
    }
    return { point: intersectPoint };
  };
  return (
    <primitive
      object={scene}
      onPointerDown={handlePointerDown}
      onPointerUp={handlePointerUp}
      onPointerMove={handlePointerMove}
    />
  );
}

function App() {
  const [partChanged, setPartChanged] = useState(false);

  const handlePartClick = (partName) => {
    if (partName === "suppressor") {
      setPartChanged((prev) => !prev); // Toggle state
    }
  };

  return (
    <div className="h-full w-full flex justify-center items-center absolute z-40">
      <Canvas camera={{ position: [0, 1, 5] }}>
        <ambientLight intensity={0.7} />
        <directionalLight intensity={1} position={[5, 5, 5]} />
        <Weapon onPartClick={handlePartClick} />
        <OrbitControls />
      </Canvas>
      {partChanged && (
        <div className="absolute top-10 right-10 text-white p-4 bg-blue-400">
          Suppressor Clicked!
        </div>
      )}
    </div>
  );
}

export default App;
