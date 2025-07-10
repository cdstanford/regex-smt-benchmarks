;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)|(^127\.0\.0\.1)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "172.31.\x18\u009F\\u0091"
(define-fun Witness1 () String (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." (str.++ "3" (str.++ "1" (str.++ "." (str.++ "\u{18}" (str.++ "\u{9f}" (str.++ "\u{5c}" (str.++ "\u{91}" ""))))))))))))
;witness2: "192.168."
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (str.to_re (str.++ "1" (str.++ "0" (str.++ "." "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." (str.++ "1" ""))))))(re.++ (re.range "6" "9") (re.range "." "."))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." (str.++ "2" ""))))))(re.++ (re.range "0" "9") (re.range "." "."))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." (str.++ "3" ""))))))(re.++ (re.range "0" "1") (re.range "." "."))))(re.union (re.++ (str.to_re "") (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." "")))))))))) (re.++ (str.to_re "") (str.to_re (str.++ "1" (str.++ "2" (str.++ "7" (str.++ "." (str.++ "0" (str.++ "." (str.++ "0" (str.++ "." (str.++ "1" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
