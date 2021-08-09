#1. ���������������� �������, ������� ����������� �� �������, ���������� ��������� 
#������������� �/��� ��������� (JOIN ���� �� ���������).


-- ����� � ���������� ����������� �������� �� ������
SELECT COUNT(id) AS news, 
  -- ������� ������ �������
  filename,
  MONTHNAME(created_at) AS month,
   -- �������� ������� �� �����
  YEAR(created_at) AS year_num,
  MONTH(created_at) AS month_num
    FROM media
    -- �������� ����������� �� �����
    GROUP BY year_num, month_num, MONTH
    -- �������� ���������� �� �����
    ORDER BY year_num DESC, month_num DESC;