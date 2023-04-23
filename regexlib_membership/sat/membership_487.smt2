;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]*)+[ ]([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]+)+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Y\'P g "
(define-fun Witness1 () String (str.++ "Y" (str.++ "'" (str.++ "P" (str.++ " " (str.++ "g" (str.++ " " "")))))))
;witness2: "lq,sM\'Z YaizMD, WazEdl "
(define-fun Witness2 () String (str.++ "l" (str.++ "q" (str.++ "," (str.++ "s" (str.++ "M" (str.++ "'" (str.++ "Z" (str.++ " " (str.++ "Y" (str.++ "a" (str.++ "i" (str.++ "z" (str.++ "M" (str.++ "D" (str.++ "," (str.++ " " (str.++ "W" (str.++ "a" (str.++ "z" (str.++ "E" (str.++ "d" (str.++ "l" (str.++ " " ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "'" "'") (re.range "," "."))) (re.* (re.union (re.range " " " ")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range " " " ")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "'" "'") (re.range "," "."))) (re.+ (re.union (re.range " " " ")(re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
