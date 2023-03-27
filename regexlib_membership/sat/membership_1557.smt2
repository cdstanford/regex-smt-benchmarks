;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[Pp]re[Ss\$]cr[iI1]pt.*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008F0\x1B\x1Aprescr1pt\u00F5"
(define-fun Witness1 () String (str.++ "\u{8f}" (str.++ "0" (str.++ "\u{1b}" (str.++ "\u{1a}" (str.++ "p" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "1" (str.++ "p" (str.++ "t" (str.++ "\u{f5}" "")))))))))))))))
;witness2: "Pre$cript"
(define-fun Witness2 () String (str.++ "P" (str.++ "r" (str.++ "e" (str.++ "$" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" ""))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (str.to_re (str.++ "r" (str.++ "e" "")))(re.++ (re.union (re.range "$" "$")(re.union (re.range "S" "S") (re.range "s" "s")))(re.++ (str.to_re (str.++ "c" (str.++ "r" "")))(re.++ (re.union (re.range "1" "1")(re.union (re.range "I" "I") (re.range "i" "i")))(re.++ (str.to_re (str.++ "p" (str.++ "t" ""))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
