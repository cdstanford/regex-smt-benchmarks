;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)|(^127\.0\.0\.1)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "172.31.\x18\u009F\\u0091"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "7" (seq.++ "2" (seq.++ "." (seq.++ "3" (seq.++ "1" (seq.++ "." (seq.++ "\x18" (seq.++ "\x9f" (seq.++ "\x5c" (seq.++ "\x91" ""))))))))))))
;witness2: "192.168."
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "." "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "." "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "7" (seq.++ "2" (seq.++ "." (seq.++ "1" ""))))))(re.++ (re.range "6" "9") (re.range "." "."))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "7" (seq.++ "2" (seq.++ "." (seq.++ "2" ""))))))(re.++ (re.range "0" "9") (re.range "." "."))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "7" (seq.++ "2" (seq.++ "." (seq.++ "3" ""))))))(re.++ (re.range "0" "1") (re.range "." "."))))(re.union (re.++ (str.to_re "") (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "." "")))))))))) (re.++ (str.to_re "") (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "7" (seq.++ "." (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "." (seq.++ "1" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
