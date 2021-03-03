from django.urls import path, include

from .views import (
    LoginView,
    LogoutView,
    UserView,
    SystemView,
    PointView,
    StationView,
    EVView,
    StationInfoView,
    EVInfoView
)


urlpatterns = [
            path('login', LoginView.as_view(), name='session_login'),
            path('logout', LogoutView.as_view(), name='session_logout'),

            path('admin/usermod/<str:username>/<str:password>', UserView.as_view(),
                name='user_create'),
            path('admin/users/<str:username>', UserView.as_view(), name='user_show'),

            path('admin/healthcheck', SystemView.as_view(), name='system_healthcheck'),
            path('admin/system/sessionupd', SystemView.as_view(),
                name='system_sessionupd'),
            path('admin/resetsessions', SystemView.as_view(),
                name='system_resetsessions'),

            path('ev', EVInfoView.as_view(), name='ev_info'),
            path('station', StationInfoView.as_view(), name='ev_info'),

            path('SessionsPerPoint/<str:point_id>/<str:date_from>/<str:date_to>',
                PointView.as_view(), name='point_sessions'),

            path('SessionsPerStation/<str:station_id>/<str:date_from>/<str:date_to>',
                StationView.as_view(), name='station_sessions'),

            path('SessionsPerEV/<str:vehicle_id>/<str:date_from>/<str:date_to>',
                EVView.as_view(), name='ev_sessions'),
]
