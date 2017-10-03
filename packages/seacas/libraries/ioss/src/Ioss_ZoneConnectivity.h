// Copyright(C) 2017 National Technology & Engineering Solutions
// of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
// NTESS, the U.S. Government retains certain rights in this software.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//
//     * Neither the name of NTESS nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef IOSS_Ioss_ZoneConnectivity_h
#define IOSS_Ioss_ZoneConnectivity_h

#include <Ioss_CodeTypes.h>
#include <array>
<<<<<<< HEAD
#include <string>

#if defined(SEACAS_HAVE_CGNS)
=======
#include <cassert>
#include <string>

#if defined(SEACAS_HAVE_CGNS) && !defined(SIERRA_PARALLEL_MPI)
>>>>>>> master
#include <cgnstypes.h>
using INT = cgsize_t;
#else
// If this is not being built with CGNS, then default to using 32-bit integers.
<<<<<<< HEAD
=======
// Currently there is no way to input/output a structured mesh without CGNS,
// so this block is simply to get things to compile and probably has no use.
>>>>>>> master
using INT = int;
#endif

namespace Ioss {
  class Region;

<<<<<<< HEAD
  struct ZoneConnectivityBase
  {
    ZoneConnectivityBase(const std::string name, int owner_zone, const std::string donor_name,
                         int donor_zone, bool owns_nodes, bool intra_block = false)
        : m_connectionName(std::move(name)), m_donorName(std::move(donor_name)),
          m_ownerZone(owner_zone), m_donorZone(donor_zone), m_ownerProcessor(-1),
          m_donorProcessor(-1), m_sameRange(false), m_ownsSharedNodes(owns_nodes),
          m_intraBlock(intra_block), m_isActive(true)
    {
    }

    ZoneConnectivityBase(const ZoneConnectivityBase &copy_from) = default;

    // Return number of nodes in the connection shared with the donor zone.
    virtual size_t get_shared_node_count() const = 0;

    bool owns_shared_nodes() const { return m_ownsSharedNodes; }

    std::string m_connectionName; // Name of the connection; either generated or from file
    std::string m_donorName; // Name of the zone (m_donorZone) to which this zone is connected via
                             // this connection.

    // NOTE: Shared nodes are "owned" by the zone with the lowest zone id.
    int  m_ownerZone;      // "id" of zone that owns this connection
    int  m_donorZone;      // "id" of zone that is donor (or other side) of this connection
    int  m_ownerProcessor; // processor that owns the owner zone
    int  m_donorProcessor; // processor that owns the donor zone
    bool m_sameRange; // True if owner and donor range should always match...(special use during
                      // decomp)
    bool m_ownsSharedNodes; // True if it is the "lower" zone id in the connection. Uses adam unless
                            // both have same adam.
    bool m_intraBlock; // True if this zc is created due to processor decompositions in a parallel
                       // run.
    bool m_isActive;   // True if non-zero range. That is, it has at least one face
  };

  struct ZoneConnectivity : public ZoneConnectivityBase
=======
  struct ZoneConnectivity
>>>>>>> master
  {
    ZoneConnectivity(const std::string name, int owner_zone, const std::string donor_name,
                     int donor_zone, const Ioss::IJK_t p_transform, const Ioss::IJK_t range_beg,
                     const Ioss::IJK_t range_end, const Ioss::IJK_t donor_beg,
                     const Ioss::IJK_t donor_end, bool owns_nodes, bool intra_block = false)
<<<<<<< HEAD
        : ZoneConnectivityBase(name, owner_zone, donor_name, donor_zone, owns_nodes, intra_block),
          m_transform(std::move(p_transform)), m_rangeBeg(std::move(range_beg)),
          m_rangeEnd(std::move(range_end)), m_donorRangeBeg(std::move(donor_beg)),
          m_donorRangeEnd(std::move(donor_end))
=======
        : m_connectionName(std::move(name)), m_donorName(std::move(donor_name)),
          m_transform(std::move(p_transform)), m_rangeBeg(std::move(range_beg)),
          m_rangeEnd(std::move(range_end)), m_donorRangeBeg(std::move(donor_beg)),
          m_donorRangeEnd(std::move(donor_end)), m_ownerZone(owner_zone), m_donorZone(donor_zone),
          m_ownsSharedNodes(owns_nodes), m_intraBlock(intra_block)
>>>>>>> master
    {
      if (!m_intraBlock) {
        m_ownerRange[0] = m_rangeBeg[0];
        m_ownerRange[1] = m_rangeBeg[1];
        m_ownerRange[2] = m_rangeBeg[2];
        m_ownerRange[3] = m_rangeEnd[0];
        m_ownerRange[4] = m_rangeEnd[1];
        m_ownerRange[5] = m_rangeEnd[2];

        m_donorRange[0] = m_donorRangeBeg[0];
        m_donorRange[1] = m_donorRangeBeg[1];
        m_donorRange[2] = m_donorRangeBeg[2];
        m_donorRange[3] = m_donorRangeEnd[0];
        m_donorRange[4] = m_donorRangeEnd[1];
        m_donorRange[5] = m_donorRangeEnd[2];
      }
    }

    ZoneConnectivity(const ZoneConnectivity &copy_from) = default;

    // Return number of nodes in the connection shared with the donor zone.
<<<<<<< HEAD
    size_t get_shared_node_count() const override
=======
    size_t get_shared_node_count() const
>>>>>>> master
    {
      size_t snc = 1;
      for (int i = 0; i < 3; i++) {
        snc *= (std::abs(m_rangeEnd[i] - m_rangeBeg[i]) + 1);
      }
      return snc;
    }

<<<<<<< HEAD
=======
    bool owns_shared_nodes() const { return m_ownsSharedNodes; }

>>>>>>> master
    std::array<INT, 9> transform_matrix() const;
    Ioss::IJK_t        transform(const Ioss::IJK_t &index_1) const;
    Ioss::IJK_t        inverse_transform(const Ioss::IJK_t &index_1) const;

    std::vector<int>     get_range(int ordinal) const;
    friend std::ostream &operator<<(std::ostream &os, const ZoneConnectivity &zgc);

    // The "original" owner and donor range -- that is, they have not been subsetted
    // due to block decompositions in a parallel run.  These should be the same on
    // all processors...  Primarily used to make parallel collective output easier...
    std::array<INT, 6> m_ownerRange{};
    std::array<INT, 6> m_donorRange{};

<<<<<<< HEAD
=======
    std::string m_connectionName; // Name of the connection; either generated or from file
    std::string m_donorName; // Name of the zone (m_donorZone) to which this zone is connected via
                             // this connection.
>>>>>>> master
    Ioss::IJK_t m_transform; // The transform.  In the same form as defined by CGNS

    // The following are all subsetted down to the portion that is actually on this zone
    // This can be different thant m_ownerRange and m_donorRange in a parallel run if the
    // decomposition splits the connection.  In a serial run, they are the same.
    //
<<<<<<< HEAD
    // One of ijk should be the same for rangeBeg and rangeEnd defining a surface.
=======
    // 1 of ijk should be the same for rangeBeg and rangeEnd defining a surface.
>>>>>>> master
    Ioss::IJK_t m_rangeBeg;      // ijk triplet defining beginning of range on this zone
    Ioss::IJK_t m_rangeEnd;      // ijk triplet defining end of range on this zone
    Ioss::IJK_t m_donorRangeBeg; // ijk triplet defining beginning of range on the connected zone
    Ioss::IJK_t m_donorRangeEnd; // ijk triplet defining end of range on the connected zone
<<<<<<< HEAD
=======

    // NOTE: Shared nodes are "owned" by the zone with the lowest zone id.
    int    m_ownerZone{};        // "id" of zone that owns this connection
    int    m_donorZone{};        // "id" of zone that is donor (or other side) of this connection
    size_t m_ownerGUID{};        // globally-unique id of owner
    size_t m_donorGUID{};        // globally-unique id of donor
    int    m_ownerProcessor{-1}; // processor that owns the owner zone
    int    m_donorProcessor{-1}; // processor that owns the donor zone
    bool   m_sameRange{
        false}; // True if owner and donor range should always match...(special use during
                  // decomp)
    bool m_ownsSharedNodes{
        false}; // True if it is the "lower" zone id in the connection. Uses adam unless
                // both have same adam.
    bool m_intraBlock{
        false}; // True if this zc is created due to processor decompositions in a parallel
                // run.
    bool m_isActive{true}; // True if non-zero range. That is, it has at least one face
>>>>>>> master
  };
} // namespace Ioss
#endif
