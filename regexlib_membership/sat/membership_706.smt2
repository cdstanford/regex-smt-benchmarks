;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d+)?-?(\d+)-(\d+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "46-2jo \u00E8\u0089"
(define-fun Witness1 () String (str.++ "4" (str.++ "6" (str.++ "-" (str.++ "2" (str.++ "j" (str.++ "o" (str.++ " " (str.++ "\u{e8}" (str.++ "\u{89}" ""))))))))))
;witness2: "-349-2\xCd"
(define-fun Witness2 () String (str.++ "-" (str.++ "3" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "\u{0c}" (str.++ "d" "")))))))))

(assert (= regexA (re.++ (re.opt (re.+ (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-") (re.+ (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
