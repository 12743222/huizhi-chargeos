import request from '@/utils/request'

// 查询对象存储列表
export function listOssConfig(query) {
  return request({
    url: '/system/ossConfig/list',
    method: 'get',
    params: query
  })
}

// 查询对象存储详细
export function getOssConfig(platformId) {
  return request({
    url: '/system/ossConfig/' + platformId,
    method: 'get'
  })
}

// 新增对象存储
export function addOssConfig(data) {
  return request({
    url: '/system/ossConfig',
    method: 'post',
    data: data
  })
}

// 修改对象存储
export function updateOssConfig(data) {
  return request({
    url: '/system/ossConfig',
    method: 'put',
    data: data
  })
}

// 删除对象存储
export function delOssConfig(platformId) {
  return request({
    url: '/system/ossConfig/' + platformId,
    method: 'delete'
  })
}
