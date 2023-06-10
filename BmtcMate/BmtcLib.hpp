#ifndef _BMTCLIB_H
#define _BMTCLIB_H

#include <string>

template <typename T>
struct BmtcResult
{
    BmtcResult(T &value) : BmtcResult(value, true){};

    BmtcResult(T &value, bool isError)
    {
        this->value = value;
        this->isError = false;
    }

    T &value;
    bool isError;
};

struct NearbyStation
{
    std::string name;
    int stationId;
    double distance;
    double latitude;
    double longitude;
};

struct Route
{
    std::string name;
    std::string route;
    std::string from;
    std::string to;
    std::string arrivalTime;
};

struct BusTrip
{
    int rowid;
    int tripid;
    std::string routeno;
    std::string routename;
    std::string busno;
    std::string tripstatus;
    std::string tripstatusid;
    std::string sourcestation;
    std::string destinationstation;
    std::string servicetype;
    std::string webservicetype;
    int servicetypeid;
    std::string lastupdatedat;
    std::string stationname;
    int stationid;
    std::string actual_arrivaltime;
    int stopstatus;
    std::string etastatus;
    std::string etastatusmapview;
    double latitude;
    double longitude;
    std::string currentstop;
    std::string laststop;
    std::string weblaststop;
    std::string nextstop;
    double currlatitude;
    double currlongitude;
    std::string sch_arrivaltime;
    std::string sch_departuretime;
    std::string eta;
    std::string actual_arrivaltime1;
    std::string actual_departudetime;
    std::string tripstarttime;
    std::string tripendtime;
    int routeid;
    int vehicleid;
    int responsecode;
    int lastreceiveddatetimeflag;
    int srno;
};

BmtcResult<NearbyStation> getNearestStation(double latitude, double longitude) noexcept;
BmtcResult<std::vector<Route>> getRoutes(int stationId) noexcept;
BmtcResult<std::vector<BusTrip>> getTrips(int vehicleId) noexcept;

#endif
