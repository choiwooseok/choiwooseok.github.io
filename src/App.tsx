import * as THREE from 'three'
import React, { useRef, useState } from 'react'
import { Canvas, useFrame, ThreeElements } from '@react-three/fiber'
import { AccumulativeShadows, RandomizedLight, Center, OrbitControls } from '@react-three/drei'

  const getRandom = (min: number, max: number) => {
    return Math.floor(Math.random() * (max - min + 1) + min);
  }

function Box(props: ThreeElements['mesh']) {
  const mesh = useRef<THREE.Mesh>(null!)
  const [hovered, setHover] = useState(false)
  const [active, setActive] = useState(false)

  useFrame((state, delta) => {
    mesh.current.rotation.x += delta * getRandom(1, 5);
    mesh.current.rotation.y += delta * getRandom(1, 5);
    mesh.current.rotation.z += delta * getRandom(1, 5);
  })
  return (
    <mesh
      {...props}
      ref={mesh}
      scale={active ? 1.2 : 0.5}
      onClick={(event) => setActive(!active)}
      onPointerOver={(event) => setHover(true)}
      onPointerOut={(event) => setHover(false)}>
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={hovered ? 'hotpink' : 'orange'} />
    </mesh>
  )
}

function Sphere() {
  return (
    <Center top>
      <mesh castShadow>
        <sphereGeometry args={[0.75, 64, 64]} />
        <meshStandardMaterial color='blue' metalness={0.7} roughness={0.7} />
      </mesh>
    </Center>
  )
}

function App() {
  return (
    <div style={{ position: "relative", width: 1200, height: 1200 }}>
      <Canvas flat linear shadows camera={{ position: [0, 0, 4.5], fov: 50 }}>
        <ambientLight />
        <pointLight position={[0, 10, 10]} />
        <group position={[0, -0.65, 0]}>
          <Box position={[1.2, 1, 1.2]} />
          <Box position={[-1.2, 1, -1.2]} />
          <Sphere />
          <AccumulativeShadows temporal frames={200} color="purple" colorBlend={0.5} opacity={1} scale={10} alphaTest={0.85}>
            <RandomizedLight amount={8} radius={5} ambient={0.5} position={[5, 3, 2]} bias={0.001} />
          </AccumulativeShadows>
        </group>
        <OrbitControls autoRotate autoRotateSpeed={10} enablePan={true} enableZoom={true} minPolarAngle={Math.PI / 2.1} maxPolarAngle={Math.PI / 2.1} />
      </Canvas>
    </div>
  );
}

export default App;
