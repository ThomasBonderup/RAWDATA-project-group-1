------------- Dummy data for testing
-- user (uconst CHARACTER(10), firstName text, lastName text, email VARCHAR(50), password VARCHAR(16), username VARCHAR(15))
insert into movie_data_model.user
values ('ui000001', 'Alex', 'Tao', 'alta@dummy.data', 'alta01pw', 'alta01'),
('ui000002', 'Nils', 'Müllenborn', 'nimu@dummy.data', 'nimu01pw', 'nimu01'),
('ui000003', 'Thomas', 'Winther', 'thwi@dummy.data', 'thwi01pw', 'thwi01'),
('ui000004', 'Emilie', 'Unna', 'emun@dummy.data', 'emun01pw', 'emun01'),
('ui000005', 'Troels', 'Andreasen', 'tran@dummy.data', 'tran01pw', 'tran01'),
('ui000006', 'Henrik', 'Bulskov', 'hebu@dummy.data', 'hebu01pw', 'hebu01');

-- name_bookmark (uconst CHARACTER(10), nconst CHARACTER(10), timestamp TIMESTAMP)
insert into movie_data_model.name_bookmark
values ('ui000001', 'nm0000048', '2020-10-08 15:49:51.634682'),
('ui000001', 'nm0000076', '2020-09-03 14:29:00.904682'),
('ui000001', 'nm0000072', '2020-10-08 17:49:51.634682'),
('ui000002', 'nm0000096', '2020-03-07 10:47:00.904682'),
('ui000002', 'nm0000117', '2020-01-08 13:49:51.634682'),
('ui000002', 'nm0000118', '2020-10-02 14:43:50.904682'),
('ui000003', 'nm0000092', '2020-10-08 17:49:01.634682'),
('ui000003', 'nm0000072', '2020-04-04 14:43:00.904682'),
('ui000003', 'nm0000096', '2020-10-08 10:49:54.634682'),
('ui000004', 'nm0000117', '2020-10-06 14:43:53.904682'),
('ui000004', 'nm0000118', '2020-08-08 19:49:31.634682'),
('ui000004', 'nm0000092', '2020-01-07 14:42:11.904682'),
('ui000005', 'nm0000092', '2020-10-08 11:49:55.634682'),
('ui000005', 'nm0000072', '2020-10-09 14:41:23.904682'),
('ui000006', 'nm0000096', '2020-10-08 12:49:25.634682'),
('ui000006', 'nm0000117', '2020-09-09 14:47:33.904682'),
('ui000006', 'nm0000124', '2020-10-08 17:49:11.634682');

-- name_notes (uconst CHARACTER(10), nconst CHARACTER(10), notes text)
insert into movie_data_model.name_notes
values ('ui000001', 'nm0000071', 'dummy n note abc1xyz'),
('ui000001', 'nm0000226', 'dummy n note abc2qwe'),
('ui000001', 'nm0000178', 'dummy n note abc3xyz'),
('ui000002', 'nm0000226', 'dummy n note abc4qwe'),
('ui000002', 'nm0000171', 'dummy n note abc5xyz'),
('ui000002', 'nm0000178', 'dummy n note abc6qwe'),
('ui000003', 'nm0000226', 'dummy n note abc7xyz'),
('ui000003', 'nm0000300', 'dummy n note abc8qwe'),
('ui000003', 'nm0000277', 'dummy n note abc9xyz'),
('ui000004', 'nm0000300', 'dummy n note abc1qwe'),
('ui000004', 'nm0000283', 'dummy n note abcxyz2'),
('ui000004', 'nm0000277', 'dummy n note abc3xyz'),
('ui000005', 'nm0000283', 'dummy n note abc4qwe'),
('ui000005', 'nm0000277', 'dummy n note abc5qwe'),
('ui000005', 'nm0000300', 'dummy n note abc6xyz'),
('ui000006', 'nm0000283', 'dummy n note abc7qwe'),
('ui000006', 'nm0000277', 'dummy n note abc8xyz'),
('ui000006', 'nm0000380', 'dummy n note abc9qwe');

-- rating (uconst CHARACTER(10), tconst CHARACTER(10), rating integer, review text)
insert into movie_data_model.rating
values ('ui000001', 'tt0312284', '7', 'Awesome! best ever :)'),
('ui000001', 'tt0167260', '3', 'Interesting, invigorating but funny 3/10'),
('ui000001', 'tt0206634', '7', 'scary stuff, but still good'),
('ui000002', 'tt0226525', '8', 'this is a dummy review'),
('ui000002', 'tt0206634', '9', 'i m to lazy to do a proper review'),
('ui000002', 'tt0206878', '4', 'good'),
('ui000003', 'tt0167260', '5', 'ok'),
('ui000003', 'tt0206634', '6', 'amazing masterpiece'),
('ui000003', 'tt0226525', '7', 'review'),
('ui000004', 'tt0206634', '3', 'there is only one movie that is worse than this, and thats the room'),
('ui000004', 'tt0206878', '5', 'good acting, shitty movie'),
('ui000004', 'tt0167260', '6', 'best comedy series ive ever seen'),
('ui000005', 'tt0206634', '6', '10th time ive seen this, still a good movie'),
('ui000005', 'tt0226525', '8', 'learned something new the second time i saw this, changed my mind, its a great movie'),
('ui000006', 'tt0206634', '8', 'this is a review again'),
('ui000006', 'tt0206878', '3', 'omg so bad'),
('ui000006', 'tt0212142', '7', 'i watch this 3 times a year');

--rating_history (uconst CHARACTER(10), tconst CHARACTER(10), timestamp TIMESTAMP, rating integer, review text)
insert into movie_data_model.rating_history
values ('ui000001', 'tt0312284', '2020-09-09 16:29:11.904682', '7', 'Awesome! best ever :)'),
('ui000001', 'tt0167260', '2020-03-05 14:37:11.904682', '3', 'Interesting, invigorating but funny 3/10'),
('ui000001', 'tt0206634', '2020-09-06 16:29:11.904682', '7', 'scary stuff, but still good'),
('ui000001', 'tt0206634', '2020-07-09 16:39:11.904682', '8', 'scary stuff, alright i guess'),
('ui000002', 'tt0226525', '2020-09-08 16:23:11.904682', '8', 'this is a dummy review'),
('ui000002', 'tt0206634', '2020-09-09 18:19:11.904682', '9', 'i m to lazy to do a proper review'),
('ui000002', 'tt0206878', '2020-09-02 16:22:11.904682', '4', 'bad'),
('ui000002', 'tt0206878', '2020-03-09 12:39:11.904682', '6', 'ok'),
('ui000002', 'tt0206878', '2020-09-06 16:26:11.904682', '8', 'good'),
('ui000003', 'tt0167260', '2020-01-09 11:39:11.904682', '5', 'ok'),
('ui000003', 'tt0206634', '2020-09-08 16:23:11.904682', '6', 'amazing masterpiece'),
('ui000003', 'tt0226525', '2020-02-09 16:29:11.904682', '7', 'review'),
('ui000004', 'tt0206634', '2020-09-09 16:57:11.904682', '3', 'there is only one movie that is worse than this, and thats the room'),
('ui000004', 'tt0206878', '2020-06-09 12:29:11.904682', '5', 'good acting, shitty movie'),
('ui000004', 'tt0206878', '2020-09-03 16:22:11.904682', '5', 'shitty movie'),
('ui000004', 'tt0206878', '2020-08-09 15:29:11.904682', '5', 'good acting, shitty movie'),
('ui000004', 'tt0167260', '2020-09-05 16:27:11.904682', '6', 'best comedy series ive ever seen'),
('ui000005', 'tt0206634', '2020-02-09 17:29:11.904682', '6', '10th time ive seen this, still a good movie'),
('ui000005', 'tt0226525', '2020-09-01 16:24:11.904682', '8', 'learned something new the second time i saw this, changed my mind, its a great movie'),
('ui000006', 'tt0206634', '2020-08-09 18:29:11.904682', '8', 'this is a review again'),
('ui000006', 'tt0206878', '2020-09-04 16:26:11.904682', '3', 'omg so bad'),
('ui000006', 'tt0212142', '2020-02-09 11:29:11.904682', '7', 'i watch this 3 times a year');

-- search_history (uconst CHARACTER(10), timestamp TIMESTAMP, search text)
insert into movie_data_model.search_history
values ('ui000001', '2020-10-08 14:23:51.904682', 'harry potter'),
('ui000001', '2020-09-09 16:29:11.904682', 'Dicaprio'),
('ui000002', '2020-02-11 19:41:31.904682', 'apples'),
('ui000002', '2020-01-02 15:19:41.904682', '2008'),
('ui000002', '2020-07-06 16:42:41.904682', 'rupert gint'),
('ui000003', '2020-10-23 12:29:21.904682', 'good place'),
('ui000003', '2020-09-09 16:29:11.904682', 'teeth'),
('ui000003', '2020-02-11 19:41:31.904682', 'limitless'),
('ui000003', '2020-01-02 15:19:41.904682', '2008'),
('ui000004', '2020-07-06 16:42:41.904682', 'skjdsdf'),
('ui000004', '2020-10-23 12:29:21.904682', 'agent 47'),
('ui000004', '2020-09-09 16:29:11.904682', '007'),
('ui000004', '2020-02-11 19:41:31.904682', 'james bond'),
('ui000005', '2020-01-02 15:29:41.904682', 'harrison ford'),
('ui000005', '2020-07-06 16:42:41.904682', 'indiana jones'),
('ui000006', '2020-10-23 12:29:21.904682', 'the blacklist'),
('ui000006', '2020-09-02 11:44:51.904682', 'the simpsons');

-- title_notes (uconst CHARACTER(10), tconst CHARACTER(10), notes text)
insert into movie_data_model.title_notes
values ('ui000001', 'tt0348596', 'dummy t note abcabc1xyz'),
('ui000001', 'tt0350041', 'dummy t note abc1abc1xyz'),
('ui000001', 'tt0351838', 'dummy t note abc1xyzabc2'),
('ui000001', 'tt0347149', 'dummy t note aabc1xyzbc3'),
('ui000002', 'tt0389448', 'dummy t note ababc1xyzc4'),
('ui000002', 'tt0388194', 'dummy t note ababc1xyzc5'),
('ui000002', 'tt0387914', 'dummy t note abc1xyzabc6'),
('ui000002', 'tt0387958', 'dummy t note abcabc1xyz7'),
('ui000003', 'tt0351838', 'dummy t note abc1xyzabc2'),
('ui000003', 'tt0347149', 'dummy t note aabc1xyzbc3'),
('ui000003', 'tt0389448', 'dummy t note ababc1xyzc4'),
('ui000003', 'tt0388194', 'dummy t note ababc1xyzc5'),
('ui000004', 'tt0387914', 'dummy t note abc1xyzabc6'),
('ui000004', 'tt0387958', 'dummy t note abcabc1xyz7'),
('ui000004', 'tt0351838', 'dummy t note abc1xyzabc2'),
('ui000004', 'tt0347149', 'dummy t note aabc1xyzbc3'),
('ui000005', 'tt0389448', 'dummy t note ababc1xyzc4'),
('ui000005', 'tt0388194', 'dummy t note ababc1xyzc5'),
('ui000005', 'tt0387914', 'dummy t note abc1xyzabc6'),
('ui000006', 'tt0387958', 'dummy t note abcabc1xyz7'),
('ui000006', 'tt0389720', 'dummy t note ababc1xyzc8');

-- title_bookmark (uconst CHARACTER(10), tconst CHARACTER(10), timestamp TIMESTAMP)
insert into movie_data_model.title_bookmark
values ('ui000001', 'tt7896606', '2020-10-08 14:49:51.904682'),
('ui000001', 'tt7897372', '2020-10-09 14:43:23.904682'),
('ui000001', 'tt7051222', '2020-08-01 19:49:31.634682'),
('ui000001', 'tt0810803', '2020-10-04 11:19:51.904682'),
('ui000001', 'tt0814006', '2020-10-06 17:49:51.634682'),
('ui000002', 'tt12762022', '2020-08-07 19:29:31.634682'),
('ui000002', 'tt12765662', '2020-10-03 14:49:51.904682'),
('ui000003', 'tt12769622', '2020-10-07 16:59:51.904682'),
('ui000003', 'tt7897372', '2020-10-03 14:19:51.904682'),
('ui000003', 'tt7051222', '2020-10-06 18:49:51.904682'),
('ui000003', 'tt0810803', '2020-10-02 17:19:11.634682'),
('ui000004', 'tt0814006', '2020-10-08 14:49:51.904682'),
('ui000004', 'tt12762022', '2020-10-05 12:29:51.904682'),
('ui000005', 'tt12765662', '2020-10-08 15:49:51.904682'),
('ui000005', 'tt12769622', '2020-10-09 14:41:23.634682'),
('ui000005', 'tt7897372', '2020-10-02 18:19:51.904682'),
('ui000005', 'tt7051222', '2020-10-05 17:49:11.634682'),
('ui000005', 'tt0810803', '2020-10-06 12:59:51.904682'),
('ui000006', 'tt0814006', '2020-10-03 14:49:51.904682'),
('ui000006', 'tt12762022', '2020-10-02 11:59:51.904682'),
('ui000006', 'tt12765662', '2020-10-05 18:49:51.634682'),
('ui000006', 'tt12769622', '2020-10-01 17:19:11.634682'),
('ui000006', 'tt1278060', '2020-10-06 14:49:51.904682');
