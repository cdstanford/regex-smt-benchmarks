;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]*)+[ ]([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]+)+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Y\'P g "
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "'" (seq.++ "P" (seq.++ " " (seq.++ "g" (seq.++ " " "")))))))
;witness2: "lq,sM\'Z YaizMD, WazEdl "
(define-fun Witness2 () String (seq.++ "l" (seq.++ "q" (seq.++ "," (seq.++ "s" (seq.++ "M" (seq.++ "'" (seq.++ "Z" (seq.++ " " (seq.++ "Y" (seq.++ "a" (seq.++ "i" (seq.++ "z" (seq.++ "M" (seq.++ "D" (seq.++ "," (seq.++ " " (seq.++ "W" (seq.++ "a" (seq.++ "z" (seq.++ "E" (seq.++ "d" (seq.++ "l" (seq.++ " " ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "'" "'") (re.range "," "."))) (re.* (re.union (re.range " " " ")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range " " " ")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "'" "'") (re.range "," "."))) (re.+ (re.union (re.range " " " ")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
