/*
 * Copyright (C) 2021 Open Source Robotics Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/

%module updateinfo
%{
#include <chrono>
#include <cstdint>
#include <functional>
#include <utility>
#include "ignition/gazebo/Entity.hh"
%}

%include "stdint.i"
%feature("nodirector") UpdateInfo;

namespace ignition
{
  namespace gazebo
  {
    /// \brief Information passed to systems on the update callback.
    /// \todo(louise) Update descriptions once reset is supported.
    struct UpdateInfo
    {
      /// \brief Total time elapsed in simulation. This will not increase while
      /// paused.
      std::chrono::steady_clock::duration simTime{0};

      /// \brief Total wall clock time elapsed. This increases even if
      /// simulation is paused.
      std::chrono::steady_clock::duration realTime{0};

      /// \brief Simulation time handled during a single update.
      std::chrono::steady_clock::duration dt{0};

      /// \brief Total number of elapsed simulation iterations.
      // cppcheck-suppress unusedStructMember
      uint64_t iterations{0};

      /// \brief True if simulation is paused, which means the simulation
      /// time is not currently running, but systems are still being updated.
      /// It is the responsibilty of a system update appropriately based on
      /// the status of paused. For example, a physics systems should not
      /// update state when paused is true.
      // cppcheck-suppress unusedStructMember
      bool paused{true};
    };
  }
}