;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http\:\/\/[a-zA-Z0-9_\-]+(?:\.[a-zA-Z0-9_\-]+)*\.[a-zA-Z]{2,4}(?:\/[a-zA-Z0-9_]+)*(?:\/[a-zA-Z0-9_]+\.[a-zA-Z]{2,4}(?:\?[a-zA-Z0-9_]+\=[a-zA-Z0-9_]+)?)?(?:\&[a-zA-Z0-9_]+\=[a-zA-Z0-9_]+)*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://ou8_.p.ZhB/83.ytw?9=x_&z=Kx"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "o" (seq.++ "u" (seq.++ "8" (seq.++ "_" (seq.++ "." (seq.++ "p" (seq.++ "." (seq.++ "Z" (seq.++ "h" (seq.++ "B" (seq.++ "/" (seq.++ "8" (seq.++ "3" (seq.++ "." (seq.++ "y" (seq.++ "t" (seq.++ "w" (seq.++ "?" (seq.++ "9" (seq.++ "=" (seq.++ "x" (seq.++ "_" (seq.++ "&" (seq.++ "z" (seq.++ "=" (seq.++ "K" (seq.++ "x" "")))))))))))))))))))))))))))))))))))
;witness2: "http://z.-S.9.Fk"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "z" (seq.++ "." (seq.++ "-" (seq.++ "S" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "F" (seq.++ "k" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.range "/" "/") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.range "?" "?")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "=" "=") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))) (re.* (re.++ (re.range "&" "&")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "=" "=") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
