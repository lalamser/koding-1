// Copyright 2013 Matthew Baird
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package core

import (
	u "github.com/araddon/gou"
	"testing"
)

func TestSearchRequest(t *testing.T) {
	qry := map[string]interface{}{
		"query": map[string]interface{}{
			"wildcard": map[string]string{"actor": "a*"},
		},
	}
	out, err := SearchRequest(true, "github", "", qry, "",0)
	//log.Println(out)
	Assert(&out != nil && err == nil, t, "Should get docs")
	Assert(out.Hits.Len() == 10, t, "Should have 10 docs but was %v", out.Hits.Len())
	Assert(u.CloseInt(out.Hits.Total, 588), t, "Should have 588 hits but was %v", out.Hits.Total)
}
