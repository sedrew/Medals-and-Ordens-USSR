local nazv = {
  ["ru"] = {
    "Медаль\n«За победу над Германией в Великой Отечественной войне\n1941-1945 гг.»",
    "Золотая медаль\n«Серп и Молот»",
    "Орден\n«Победа»",
    "Орден\nЛенина",
    "Медаль\n«Золотая Звезда»",
    "Медаль\n«Партизану Отечественной войны»\nI степени",
    "Медаль\nУшакова",
    "Орден\nСуворова III степени",
    "Медаль\nНахимова",
    "Орден\nБогдана Хмельницкого\nI степени",
    "Медаль\n«За отвагу»\n1938 года",
    "Орден\nКутузова I степени ",
    "Медаль «Партизану Отечественной войны»\nII степени ",
    "Медаль\n«За взятие Берлина»",
    "Орден\nКутузова II степени ",
    "Орден\nОтечественной войны\nI степени",
    "Медаль\n«За трудовую доблесть»\n1938 года",
    "Орден\nСлавы I степени ",
    "Орден\nКутузова III степени",
    "Медаль\n«За взятие Будапешта»",
    "Орден\nСлавы II степени",
    "Орден\nНахимова I степени",
    "Орден\nКрасного Знамени",
    "«Медаль\nматеринства» I степени",
    "Медаль\n«За оборону Кавказа»",
    "Орден\nКрасной звезды",
    "Орден\nСуворова I степени",
    "Медаль\n«За отвагу» 1943 года",
    "Медаль\n«За оборону Одессы»",
    "Орден\n«Материнская слава»\nII степени",
    "Орден\nСуворова II степени",
    "Медаль\n«За оборону Ленинграда»",
    "Орден\nУшакова I степени",
    "Медаль\n«За оборону Севастополя»",
    "Юбилейная медаль\n«ХХ лет Рабоче-Крестьянской Красной Армии»\n1943 года",
    "Орден\nУшакова II степени",
    "«Медаль материнства»\nII степени",
    "Медаль\n«За боевые заслуги»",
    "Орден\nОтечественной войны\nII степени",
    "Орден\nАлександра Невского",
    "Медаль\n«За победу над Японией»",
    "Медаль\n«За освобождение Праги»",
    "Орден\nСлавы III степени",
    "Медаль\n«За освобождение Варшавы»",
    "Орден\nНахимова II степени",
    "Медаль\n«За освобождение Белграда»",
    "Медаль\n«За взятие Вены»",
    "Орден\n«Материнская слава»\nIII степени",
    "Медаль\n«За взятие Кенигсберга» ",
    "Медаль\n«За доблестный труд в Великой Отечественной войне 1941-1945 гг.»",
    "Орден\n«Материнская слава»\nI степени",
    "Медаль\n«За обороне Советского Заполярья»",
    "Медаль\n«За оборону Москвы»",
    "Орден\nБогдана Хмельницкого\nII степени",
    "Медаль\n«За оборону Сталинграда»",
    "Медаль\n«За трудовое отличие» ",
    "Медаль\n«За трудовую доблесть»\n1943 года",
    "Орден\nБогдана Хмельницкого\nIII степени",
    "Юбилейная медаль\n«ХХ лет Рабоче-Крестьянской Красной Армии»\n1938 года",
    "Медаль\n«За освобождение Кореи»",
  },
  ["en"] = {
    "Медаль\n«За победу над Германией в Великой Отечественной войне\n1941-1945 гг.»",
    "Золотая медаль\n«Серп и Молот»",
    "Орден\n«Победа»",
    "Орден\nЛенина",
    "Медаль\n«Золотая Звезда»",
    "Медаль\n«Партизану Отечественной войны»\nI степени",
    "Медаль\nУшакова",
    "Орден\nСуворова III степени",
    "Медаль\nНахимова",
    "Орден\nБогдана Хмельницкого\nI степени",
    "Медаль\n«За отвагу»\n1938 года",
    "Орден\nКутузова I степени ",
    "Медаль «Партизану Отечественной войны»\nII степени ",
    "Медаль\n«За взятие Берлина»",
    "Орден\nКутузова II степени ",
    "Орден\nОтечественной войны\nI степени",
    "Медаль\n«За трудовую доблесть»\n1938 года",
    "Орден\nСлавы I степени ",
    "Орден\nКутузова III степени",
    "Медаль\n«За взятие Будапешта»",
    "Орден\nСлавы II степени",
    "Орден\nНахимова I степени",
    "Орден\nКрасного Знамени",
    "«Медаль\nматеринства» I степени",
    "Медаль\n«За оборону Кавказа»",
    "Орден\nКрасной звезды",
    "Орден\nСуворова I степени",
    "Медаль\n«За отвагу» 1943 года",
    "Медаль\n«За оборону Одессы»",
    "Орден\n«Материнская слава»\nII степени",
    "Орден\nСуворова II степени",
    "Медаль\n«За оборону Ленинграда»",
    "Орден\nУшакова I степени",
    "Медаль\n«За оборону Севастополя»",
    "Юбилейная медаль\n«ХХ лет Рабоче-Крестьянской Красной Армии»\n1943 года",
    "Орден\nУшакова II степени",
    "«Медаль материнства»\nII степени",
    "Медаль\n«За боевые заслуги»",
    "Орден\nОтечественной войны\nII степени",
    "Орден\nАлександра Невского",
    "Медаль\n«За победу над Японией»",
    "Медаль\n«За освобождение Праги»",
    "Орден\nСлавы III степени",
    "Медаль\n«За освобождение Варшавы»",
    "Орден\nНахимова II степени",
    "Медаль\n«За освобождение Белграда»",
    "Медаль\n«За взятие Вены»",
    "Орден\n«Материнская слава»\nIII степени",
    "Медаль\n«За взятие Кенигсберга» ",
    "Медаль\n«За доблестный труд в Великой Отечественной войне 1941-1945 гг.»",
    "Орден\n«Материнская слава»\nI степени",
    "Медаль\n«За обороне Советского Заполярья»",
    "Медаль\n«За оборону Москвы»",
    "Орден\nБогдана Хмельницкого\nII степени",
    "Медаль\n«За оборону Сталинграда»",
    "Медаль\n«За трудовое отличие» ",
    "Медаль\n«За трудовую доблесть»\n1943 года",
    "Орден\nБогдана Хмельницкого\nIII степени",
    "Юбилейная медаль\n«ХХ лет Рабоче-Крестьянской Красной Армии»\n1938 года",
    "Медаль\n«За освобождение Кореи»",
  }
}
return nazv
