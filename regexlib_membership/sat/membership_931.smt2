;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){7}[0-9a-zA-Z,#/ \.\(\)\-\+\*]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "TZ# Cx E99Y8k1#/-72 t0z."
(define-fun Witness1 () String (seq.++ "T" (seq.++ "Z" (seq.++ "#" (seq.++ " " (seq.++ "C" (seq.++ "x" (seq.++ " " (seq.++ "E" (seq.++ "9" (seq.++ "9" (seq.++ "Y" (seq.++ "8" (seq.++ "k" (seq.++ "1" (seq.++ "#" (seq.++ "/" (seq.++ "-" (seq.++ "7" (seq.++ "2" (seq.++ " " (seq.++ "t" (seq.++ "0" (seq.++ "z" (seq.++ "." "")))))))))))))))))))))))))
;witness2: "9d99jY287 k8s"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "d" (seq.++ "9" (seq.++ "9" (seq.++ "j" (seq.++ "Y" (seq.++ "2" (seq.++ "8" (seq.++ "7" (seq.++ " " (seq.++ "k" (seq.++ "8" (seq.++ "s" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 7 7) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
