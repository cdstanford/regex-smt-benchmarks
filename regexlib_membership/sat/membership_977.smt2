;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<value>([\+-]?((\d*\.\d+)|\d+))(E[\+-]?\d+)?)( (?<prefix>[PTGMkmunpf])?(?<unit>[a-zA-Z]+)?)?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E4,\u00D3-4.8898 "
(define-fun Witness1 () String (str.++ "\u{e4}" (str.++ "," (str.++ "\u{d3}" (str.++ "-" (str.++ "4" (str.++ "." (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ " " ""))))))))))))
;witness2: "6E+37"
(define-fun Witness2 () String (str.++ "6" (str.++ "E" (str.++ "+" (str.++ "3" (str.++ "7" ""))))))

(assert (= regexA (re.++ (re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (re.+ (re.range "0" "9")))) (re.opt (re.++ (re.range "E" "E")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9")))))) (re.opt (re.++ (re.range " " " ")(re.++ (re.opt (re.union (re.range "G" "G")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "T" "T")(re.union (re.range "f" "f")(re.union (re.range "k" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p") (re.range "u" "u")))))))))) (re.opt (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
