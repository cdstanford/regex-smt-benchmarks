;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((19|20)[\d]{2}/[\d]{6}/[\d]{2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CA\xD\u00FC\u00C7o1961/680905/79\u00CA"
(define-fun Witness1 () String (seq.++ "\xca" (seq.++ "\x0d" (seq.++ "\xfc" (seq.++ "\xc7" (seq.++ "o" (seq.++ "1" (seq.++ "9" (seq.++ "6" (seq.++ "1" (seq.++ "/" (seq.++ "6" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "/" (seq.++ "7" (seq.++ "9" (seq.++ "\xca" "")))))))))))))))))))))
;witness2: "\u00D7\u008C2028/479218/96"
(define-fun Witness2 () String (seq.++ "\xd7" (seq.++ "\x8c" (seq.++ "2" (seq.++ "0" (seq.++ "2" (seq.++ "8" (seq.++ "/" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "1" (seq.++ "8" (seq.++ "/" (seq.++ "9" (seq.++ "6" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.range "/" "/") ((_ re.loop 2 2) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
