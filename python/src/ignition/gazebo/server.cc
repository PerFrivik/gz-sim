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

#include <iostream>

#include "server.hh"

namespace ignition
{
namespace gazebo
{
namespace python
{
void define_gazebo_server(py::object module)
{
  py::class_<ignition::gazebo::Server>(module, "Server")
  .def(py::init<ignition::gazebo::ServerConfig &>())
  .def(
    "run", &ignition::gazebo::Server::Run,
    "Run server")
  .def(
    "has_entity", &ignition::gazebo::Server::HasEntity,
    "Return true if the specified world has an entity with the provided name.")
  .def(
    "is_running", py::overload_cast<>(&ignition::gazebo::Server::Running, py::const_),
    "empty");

}

}  // namespace python
}  // namespace gazebo
}  // namespace ignition