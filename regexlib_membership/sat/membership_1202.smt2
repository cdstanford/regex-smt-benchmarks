;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "z2K@8aw.z9-h3.uZwdz8@9.yaNMBt.t-.@-.XaqUwg8Z@6.xUb"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "2" (seq.++ "K" (seq.++ "@" (seq.++ "8" (seq.++ "a" (seq.++ "w" (seq.++ "." (seq.++ "z" (seq.++ "9" (seq.++ "-" (seq.++ "h" (seq.++ "3" (seq.++ "." (seq.++ "u" (seq.++ "Z" (seq.++ "w" (seq.++ "d" (seq.++ "z" (seq.++ "8" (seq.++ "@" (seq.++ "9" (seq.++ "." (seq.++ "y" (seq.++ "a" (seq.++ "N" (seq.++ "M" (seq.++ "B" (seq.++ "t" (seq.++ "." (seq.++ "t" (seq.++ "-" (seq.++ "." (seq.++ "@" (seq.++ "-" (seq.++ "." (seq.++ "X" (seq.++ "a" (seq.++ "q" (seq.++ "U" (seq.++ "w" (seq.++ "g" (seq.++ "8" (seq.++ "Z" (seq.++ "@" (seq.++ "6" (seq.++ "." (seq.++ "x" (seq.++ "U" (seq.++ "b" "")))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "-Gaf_@_.gCkTzx;-@h.QGfw"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "G" (seq.++ "a" (seq.++ "f" (seq.++ "_" (seq.++ "@" (seq.++ "_" (seq.++ "." (seq.++ "g" (seq.++ "C" (seq.++ "k" (seq.++ "T" (seq.++ "z" (seq.++ "x" (seq.++ ";" (seq.++ "-" (seq.++ "@" (seq.++ "h" (seq.++ "." (seq.++ "Q" (seq.++ "G" (seq.++ "f" (seq.++ "w" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.union (re.range "." ".") (re.range ";" ";")) (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
