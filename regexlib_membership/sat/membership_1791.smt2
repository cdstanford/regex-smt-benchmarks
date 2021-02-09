;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((https?|ftp)\://((\[?(\d{1,3}\.){3}\d{1,3}\]?)|(([-a-zA-Z0-9]+\.)+[a-zA-Z]{2,4}))(\:\d+)?(/[-a-zA-Z0-9._?,'+&amp;%$#=~\\]+)*/?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ftp://F7-.-.0.h-.9a.INW:9/"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "F" (seq.++ "7" (seq.++ "-" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "0" (seq.++ "." (seq.++ "h" (seq.++ "-" (seq.++ "." (seq.++ "9" (seq.++ "a" (seq.++ "." (seq.++ "I" (seq.++ "N" (seq.++ "W" (seq.++ ":" (seq.++ "9" (seq.++ "/" "")))))))))))))))))))))))))))
;witness2: "ftp://-.T.Zyt"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "." (seq.++ "T" (seq.++ "." (seq.++ "Z" (seq.++ "y" (seq.++ "t" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" ""))))) (re.opt (re.range "s" "s"))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.union (re.++ (re.opt (re.range "[" "["))(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." ".")))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.range "]" "]"))))) (re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))) ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/") (re.+ (re.union (re.range "#" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))))))) (re.opt (re.range "/" "/"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
