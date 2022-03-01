// Copyright 2021 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <pybind11/pybind11.h>

#include "Angle.hh"
#include "AxisAlignedBox.hh"
#include "Box.hh"
#include "Color.hh"
#include "Cylinder.hh"
#include "DiffDriveOdometry.hh"
#include "Filter.hh"
#include "Frustum.hh"
#include "GaussMarkovProcess.hh"
#include "Helpers.hh"
#include "Inertial.hh"
#include "Kmeans.hh"
#include "Line2.hh"
#include "Line3.hh"
#include "MassMatrix3.hh"
#include "Material.hh"
#include "Matrix3.hh"
#include "Matrix4.hh"
#include "MovingWindowFilter.hh"
#include "OrientedBox.hh"
#include "PID.hh"
#include "Plane.hh"
#include "Pose3.hh"
#include "Quaternion.hh"
#include "Rand.hh"
#include "RollingMean.hh"
#include "RotationSpline.hh"
#include "SemanticVersion.hh"
#include "SignalStats.hh"
#include "Sphere.hh"
#include "SphericalCoordinates.hh"
#include "Spline.hh"
#include "StopWatch.hh"
#include "Temperature.hh"
#include "Triangle.hh"
#include "Triangle3.hh"
#include "Vector2.hh"
#include "Vector3.hh"
#include "Vector3Stats.hh"
#include "Vector4.hh"

namespace py = pybind11;

PYBIND11_MODULE(math, m)
{
  m.doc() = "Ignition Math Python Library.";

  ignition::math::python::defineMathAngle(m, "Angle");

  ignition::math::python::defineMathAxisAlignedBox(m, "AxisAlignedBox");

  ignition::math::python::defineMathColor(m, "Color");

  ignition::math::python::defineMathDiffDriveOdometry(
    m, "DiffDriveOdometry");

  ignition::math::python::defineMathGaussMarkovProcess(
    m, "GaussMarkovProcess");

  ignition::math::python::defineMathHelpers(m);

  ignition::math::python::defineMathKmeans(m, "Kmeans");

  ignition::math::python::defineMathMaterial(m, "Material");

  ignition::math::python::defineMathMovingWindowFilter(m, "MovingWindowFilter");

  ignition::math::python::defineMathPID(m, "PID");

  ignition::math::python::defineMathRand(m, "Rand");

  ignition::math::python::defineMathRollingMean(m, "RollingMean");

  ignition::math::python::defineMathSignalStats(m, "SignalStats");
  ignition::math::python::defineMathSignalStatistic(m, "SignalStatistic");
  ignition::math::python::defineMathSignalVariance(m, "SignalVariance");
  ignition::math::python::defineMathSignalMaximum(m, "SignalMaximum");
  ignition::math::python::defineMathSignalMinimum(m, "SignalMinimum");
  ignition::math::python::defineMathSignalMaxAbsoluteValue(
    m, "SignalMaxAbsoluteValue");
  ignition::math::python::defineMathSignalRootMeanSquare(
    m, "SignalRootMeanSquare");
  ignition::math::python::defineMathSignalMean(m, "SignalMean");

  ignition::math::python::defineMathRotationSpline(m, "RotationSpline");

  ignition::math::python::defineMathVector3Stats(m, "Vector3Stats");

  ignition::math::python::defineMathSemanticVersion(m, "SemanticVersion");

  ignition::math::python::defineMathSphericalCoordinates(
    m, "SphericalCoordinates");

  ignition::math::python::defineMathSpline(m, "Spline");

  ignition::math::python::defineMathStopwatch(m, "Stopwatch");

  ignition::math::python::defineMathTemperature(m, "Temperature");

  ignition::math::python::defineMathVector2(m, "Vector2");

  ignition::math::python::defineMathVector3(m, "Vector3");

  ignition::math::python::defineMathPlane<double>(m, "Planed");

  ignition::math::python::defineMathBox<double>(m, "Boxd");
  ignition::math::python::defineMathBox<float>(m, "Boxf");

  ignition::math::python::defineMathVector4(m, "Vector4");

  ignition::math::python::defineMathLine2(m, "Line2");

  ignition::math::python::defineMathLine3(m, "Line3");

  ignition::math::python::defineMathMatrix3<int>(m, "Matrix3i");
  ignition::math::python::defineMathMatrix3<double>(m, "Matrix3d");
  ignition::math::python::defineMathMatrix3<float>(m, "Matrix3f");

  ignition::math::python::defineMathMatrix4<int>(m, "Matrix4i");
  ignition::math::python::defineMathMatrix4<double>(m, "Matrix4d");
  ignition::math::python::defineMathMatrix4<float>(m, "Matrix4f");

  ignition::math::python::defineMathTriangle<int>(m, "Trianglei");
  ignition::math::python::defineMathTriangle<double>(m, "Triangled");
  ignition::math::python::defineMathTriangle<float>(m, "Trianglef");

  ignition::math::python::defineMathTriangle3<int>(m, "Triangle3i");
  ignition::math::python::defineMathTriangle3<double>(m, "Triangle3d");
  ignition::math::python::defineMathTriangle3<float>(m, "Triangle3f");

  ignition::math::python::defineMathQuaternion<int>(m, "Quaternioni");
  ignition::math::python::defineMathQuaternion<double>(m, "Quaterniond");
  ignition::math::python::defineMathQuaternion<float>(m, "Quaternionf");

  ignition::math::python::defineMathOrientedBox<double>(m, "OrientedBoxd");

  ignition::math::python::defineMathPose3<int>(m, "Pose3i");
  ignition::math::python::defineMathPose3<double>(m, "Pose3d");
  ignition::math::python::defineMathPose3<float>(m, "Pose3f");

  ignition::math::python::defineMathMassMatrix3<double>(m, "MassMatrix3d");
  ignition::math::python::defineMathMassMatrix3<float>(m, "MassMatrix3f");

  ignition::math::python::defineMathSphere<double>(m, "Sphered");

  ignition::math::python::defineMathCylinder<double>(m, "Cylinderd");

  ignition::math::python::defineMathInertial<double>(m, "Inertiald");

  ignition::math::python::defineMathFrustum(m, "Frustum");

  ignition::math::python::defineMathFilter(m, "Filter");

  ignition::math::python::defineMathBiQuad(m, "BiQuad");

  ignition::math::python::defineMathBiQuadVector3(
    m, "BiQuadVector3");

  ignition::math::python::defineMathOnePole(m, "OnePole");

  ignition::math::python::defineMathOnePoleQuaternion(
    m, "OnePoleQuaternion");
  ignition::math::python::defineMathOnePoleVector3(
    m, "OnePoleVector3");
}