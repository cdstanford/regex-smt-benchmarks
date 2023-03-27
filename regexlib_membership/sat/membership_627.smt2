;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /Dr[.]?|Phd[.]?|MBA/i
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C8\u00F9MBA/i"
(define-fun Witness1 () String (str.++ "\u{c8}" (str.++ "\u{f9}" (str.++ "M" (str.++ "B" (str.++ "A" (str.++ "/" (str.++ "i" ""))))))))
;witness2: "\u00C4\u00C2\u00FFwPhd.\u00E3\u00E5"
(define-fun Witness2 () String (str.++ "\u{c4}" (str.++ "\u{c2}" (str.++ "\u{ff}" (str.++ "w" (str.++ "P" (str.++ "h" (str.++ "d" (str.++ "." (str.++ "\u{e3}" (str.++ "\u{e5}" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "/" (str.++ "D" (str.++ "r" "")))) (re.opt (re.range "." ".")))(re.union (re.++ (str.to_re (str.++ "P" (str.++ "h" (str.++ "d" "")))) (re.opt (re.range "." "."))) (str.to_re (str.++ "M" (str.++ "B" (str.++ "A" (str.++ "/" (str.++ "i" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
