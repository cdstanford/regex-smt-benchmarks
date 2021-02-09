;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http|https|ftp)\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+&amp;%\$#\=~])*[^\.\,\)\(\s]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "https://8.xy/\u00EF"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "8" (seq.++ "." (seq.++ "x" (seq.++ "y" (seq.++ "/" (seq.++ "\xef" "")))))))))))))))
;witness2: "https://-.xy:8/L"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "." (seq.++ "x" (seq.++ "y" (seq.++ ":" (seq.++ "8" (seq.++ "/" (seq.++ "L" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" "")))))) (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" ""))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.range ":" ":") (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "#" "'")(re.union (re.range "+" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))))(re.++ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
