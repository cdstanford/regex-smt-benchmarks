;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((19|20)[\d]{2}/[\d]{6}/[\d]{2})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CA\xD\u00FC\u00C7o1961/680905/79\u00CA"
(define-fun Witness1 () String (str.++ "\u{ca}" (str.++ "\u{0d}" (str.++ "\u{fc}" (str.++ "\u{c7}" (str.++ "o" (str.++ "1" (str.++ "9" (str.++ "6" (str.++ "1" (str.++ "/" (str.++ "6" (str.++ "8" (str.++ "0" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "/" (str.++ "7" (str.++ "9" (str.++ "\u{ca}" "")))))))))))))))))))))
;witness2: "\u00D7\u008C2028/479218/96"
(define-fun Witness2 () String (str.++ "\u{d7}" (str.++ "\u{8c}" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "8" (str.++ "/" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "/" (str.++ "9" (str.++ "6" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.range "/" "/") ((_ re.loop 2 2) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
