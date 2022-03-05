from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from django.conf.urls import url

from trucks.views import home
from users.views import CustomObtainAuthToken

admin.site.site_title = 'Mikhuy'
admin.site.index_title = 'Admin'
admin.site.site_header = 'Mikhuy Administration'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('users.urls')),
    path('login/', CustomObtainAuthToken.as_view()),
    path('accounts/', include('accounts.urls')),
    path('products/', include('products.urls')),
    path('cart/', include('cart.urls')),
    path('orders/', include('order.urls')),
    path('trucks/', include('trucks.urls')),
    path('', view=home, name='home'),

]

# urlpatterns += static(settings.STATIC_URL,
#                       document_root=settings.STATIC_ROOT)
# urlpatterns += static(settings.MEDIA_URL,
#                       document_root=settings.MEDIA_ROOT)
