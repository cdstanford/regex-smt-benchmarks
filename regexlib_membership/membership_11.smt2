;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1[8,9]|20)[0-9]{2}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CF2078\x0"
(define-fun Witness1 () String (str.++ "\u{cf}" (str.++ "2" (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "\u{00}" "")))))))
;witness2: "t\u00F51,89\u008B\u008D\u00EA\x17\u0094\x3"
(define-fun Witness2 () String (str.++ "t" (str.++ "\u{f5}" (str.++ "1" (str.++ "," (str.++ "8" (str.++ "9" (str.++ "\u{8b}" (str.++ "\u{8d}" (str.++ "\u{ea}" (str.++ "\u{17}" (str.++ "\u{94}" (str.++ "\u{03}" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "1" "1") (re.union (re.range "," ",") (re.range "8" "9"))) (str.to_re (str.++ "2" (str.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
